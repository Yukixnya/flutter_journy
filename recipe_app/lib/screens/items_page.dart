import 'package:flutter/material.dart';
import 'package:recipe_app/data/item_data.dart';
import 'package:recipe_app/widgets/item_card.dart';

class ItemsPage extends StatelessWidget {
  final int categoryId;
  final String title;

  const ItemsPage({
    required this.title,
    required this.categoryId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final categoryItems = items[categoryId]!;    

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: ListView.builder(
        itemCount: categoryItems.length,
        itemBuilder: (context, index) {
          return ItemCard(
            items: categoryItems[index],
          );
        },
      ),
    );
  }
}