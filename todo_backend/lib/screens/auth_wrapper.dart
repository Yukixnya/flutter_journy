import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_backend/providers/auth_provider.dart';
import 'package:todo_backend/screens/login_page.dart';
import 'package:todo_backend/screens/todo_home.dart';

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    return authState.when(
      data: (user) => user != null ? TodoHome() : LoginPage(),
      error: (error, stackTrace) => Scaffold(
        body: Center(
          child: Text('Something went wrong: $error'),
        ),
      ),
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      )
    );
  }
}
