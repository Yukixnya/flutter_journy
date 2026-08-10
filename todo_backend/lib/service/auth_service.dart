import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_backend/models/user_model.dart';

class AuthService {
  final Ref ref;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AuthService(this.ref);

  Future<UserCredential> signIn(String email, String password) async {
    try {

      bool userExixts = await _checkUserExists(email);
      if (!userExixts) {
        throw Exception('User does not exist, Please register first');
      }

      final UserCredential user_data = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _saveUserState(true);
      return user_data;
    } catch (e) {
      throw Exception('Failed to sign in: $e');
    }
  }

  Future<UserCredential> signUp(String username, String email, String password) async {
    try {

      bool userExixts = await _checkUserExists(email);
      if (userExixts) {
        throw Exception('User already exists, Please login instead');
      }

      final UserCredential userData = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      await userData.user?.updateDisplayName(username);
      await _addUserToFirestore(username, email);
      await _saveUserState(true);
      return userData;
    } catch (e) {
      throw Exception('Failed to sign up: $e');
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await _saveUserState(false);
    } catch (e) {
      throw Exception('Failed to sign out: $e');
    }
  }

  Future<void> _addUserToFirestore(
    String username,
    String email,
  ) async {
    UserModel _user = UserModel(username: username, email: email);
    try {
      await _firestore.collection('users').add(_user.userModelToMap());
    } catch (e) {
      throw Exception('Failed to add user to Firestore: $e');
    }
  }

  Future<bool> _checkUserExists(String email) async{
    try{
      final QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore.collection('users').where('email', isEqualTo: email).limit(1).get();
      return querySnapshot.docs.isNotEmpty;
    }
    catch(e){
      throw Exception('Failed to check user in Firestore: $e');
    }
  }

  Future<String?> getUserName(String email) async {
    try {
      final querySnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.data()['username'] as String?;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<void> _saveUserState(bool isLoggedIn) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
  }

  Future<bool> _getUserState() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }
}
