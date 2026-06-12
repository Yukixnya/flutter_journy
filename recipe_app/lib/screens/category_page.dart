import 'package:flutter/material.dart';
import 'package:recipe_app/data/category_data.dart';
import 'package:recipe_app/screens/items_page.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Category",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: GridView(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        children: List.generate(categories.length, (index) {
          return InkWell(
            onTap: () {
              // print(categories[index].title);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ItemsPage(
                    title: categories[index].title,
                    categoryId: categories[index].id,
                  ),
                ),
              );
            },

            child: Container(
              padding: const EdgeInsets.all(16),
              // color: categories[index].color,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [
                    categories[index].color.withOpacity(0.5),
                    categories[index].color.withOpacity(0.9),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Text(
                categories[index].title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
