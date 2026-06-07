import 'package:flutter/material.dart';
import 'package:journal_app/screens/journal_home.dart';

class JournalAPP extends StatelessWidget{
  const JournalAPP({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Journal App",
      home: JournalHome(),
    );
  }
}
