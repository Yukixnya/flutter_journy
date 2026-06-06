import 'package:flutter/material.dart';
import 'package:quote_gen_app/screens/home_page.dart';

class QuoteGenApp extends StatelessWidget{
  const QuoteGenApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Quote Generator',
      home: const QuoteGenHomePage(),
    );
  }
}