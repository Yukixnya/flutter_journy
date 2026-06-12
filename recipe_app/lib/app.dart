import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_app/screens/category_page.dart';

class RecipeApp extends StatelessWidget{
  const RecipeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 180, 11, 57)),
        textTheme: GoogleFonts.latoTextTheme(),
        scaffoldBackgroundColor: Colors.black,
      ),
      home: CategoryPage(),
    );
  }
}