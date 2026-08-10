import 'package:flutter/material.dart';
import 'package:todo_backend/screens/auth_wrapper.dart';

class TodoAPP extends StatelessWidget{
  const TodoAPP({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Todo App",
      home: AuthWrapper(),
    );
  }
}
