import 'package:flutter/material.dart';
import 'package:recipe_app/models/item_model.dart';

class ItemDetailsPage extends StatelessWidget {
  final ItemModel items;

  const ItemDetailsPage({required this.items, super.key});

  @override
  Widget build(BuildContext context) {
    final String contains = items.isGlutenFree
        ? "This contains Gluten."
        : "This is Gluten Free food.";
    return Scaffold(
      appBar: AppBar(
        title: Text(
          items.name,
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                items.img,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 250,
              ),
              SizedBox(height: 15),
              Text(
                "Ingridents:",
                style: TextStyle(color: Colors.pink[400], fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: items.ingridents.map((ingredient) {
                  return Text(
                    "• $ingredient",
                    style: const TextStyle(color: Colors.white,fontSize: 15),
                  );
                }).toList(),
              ),
              SizedBox(height: 15),
              Text(
                "Steps:",
                style: TextStyle(color: Colors.pink[400], fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: items.steps.map((step) {
                  return Text(
                    "• $step\n",
                    style: const TextStyle(color: Colors.white,fontSize: 15),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              Text(
                "'' $contains ''",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
