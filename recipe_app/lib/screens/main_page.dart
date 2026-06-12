import 'package:flutter/material.dart';
import 'package:recipe_app/screens/category_page.dart';
import 'package:recipe_app/screens/saved_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPage();
}

class _MainPage extends State<MainPage> {

  final List<Widget> _pages = [
    CategoryPage(),
    SavedPage()
  ];

  int cur_index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[cur_index],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        selectedItemColor: Colors.pink[400],
        unselectedItemColor: Colors.white70,
        currentIndex: cur_index,
        onTap: (index) {
          setState(() {
            cur_index = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.category),label: "Categories"),
          BottomNavigationBarItem(icon: Icon(Icons.save), label: "Saved")
        ],
      ),
    );
  }
}
