import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_backend/models/user_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class AuthService {
  final Ref ref;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveUserToken(String userId) async {
    final token = await FirebaseMessaging.instance.getToken();
    await _firestore.collection('users').doc(userId).set({'fcmToken':token}, SetOptions(merge: true));
  }

  AuthService(this.ref);

  Future<UserCredential> signIn(String email, String password) async {
    try {

      final UserCredential userData = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userData.user != null) {
        await saveUserToken(userData.user!.uid);
      }
      await _saveUserState(true);
      return userData;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          throw Exception('No user found for that email.');
        case 'wrong-password':
          throw Exception('Wrong password provided.');
        case 'invalid-credential':
          throw Exception('Invalid email or password.');
        case 'user-disabled':
          throw Exception('This user account has been disabled.');
        case 'invalid-email':
          throw Exception('The email address is invalid.');
        case 'too-many-requests':
          throw Exception('Too many login attempts. Please try again later.');
        default:
          throw Exception(e.message ?? 'An unknown authentication error occurred.');
      }
    } on FirebaseException catch (e) {
      throw Exception('Firestore error: ${e.message}');
    } catch (e) {
      throw Exception('Failed to sign in: $e');
    }
  }

  Future<UserCredential> signUp(String username, String email, String password) async {
    try {

      final UserCredential userData = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      
      await userData.user?.updateDisplayName(username);
      await _addUserToFirestore(userData.user?.uid ?? '', username, email);
      if (userData.user != null) {
        await saveUserToken(userData.user!.uid);
      }
      await _saveUserState(true);

      return userData;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          throw Exception('The email address is already in use by another account.');
        case 'weak-password':
          throw Exception('The password provided is too weak.');
        case 'operation-not-allowed':
          throw Exception('Email/password accounts are not enabled.');
        case 'invalid-email':
          throw Exception('The email address is invalid.');
        default:
          throw Exception(e.message ?? 'An unknown registration error occurred.');
      }
    } on FirebaseException catch (e) {
      throw Exception('Firestore error: ${e.message}');
    } catch (e) {
      throw Exception('Failed to sign up: $e');
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await _saveUserState(false);
    } on FirebaseAuthException catch (e) {
      throw Exception('Firebase Auth error during sign out: ${e.message}');
    } catch (e) {
      throw Exception('Failed to sign out: $e');
    }
  }

  Future<void> _addUserToFirestore(
    String uid,
    String username,
    String email,
  ) async {
    UserModel userModel = UserModel(username: username, email: email);
    try {
      if (uid.isNotEmpty) {
        await _firestore.collection('users').doc(uid).set(userModel.userModelToMap());
      } else {
        await _firestore.collection('users').add(userModel.userModelToMap());
      }
    } on FirebaseException catch (e) {
      switch (e.code) {
        case 'permission-denied':
          throw Exception('You do not have permission to write to Firestore.');
        case 'unavailable':
          throw Exception('Firestore service is currently unavailable.');
        default:
          throw Exception('Firestore error adding user: ${e.message}');
      }
    } catch (e) {
      throw Exception('Failed to add user to Firestore: $e');
    }
  }

  Future<bool> _checkUserExists(String email) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();
      return querySnapshot.docs.isNotEmpty;
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        return false; 
      }
      throw Exception('Firestore error checking user: ${e.message}');
    } catch (e) {
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
    } on FirebaseException catch (e) {
      print('Firestore error fetching username: ${e.message}');
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
