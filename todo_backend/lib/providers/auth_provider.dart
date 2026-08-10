import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_backend/service/auth_service.dart';

final authService = Provider<AuthService>((ref) => AuthService(ref));

final authServiceProvider = Provider<AuthService>((ref) => AuthService(ref));

final authStateProvider = StreamProvider<User?>(
  (ref) => FirebaseAuth.instance.authStateChanges(),
);
