import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/models/item_model.dart';
import 'package:recipe_app/providers/saved_provider.dart';

class ItemDetailsPage extends ConsumerWidget {
  final ItemModel item;

  const ItemDetailsPage({required this.item, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<ItemModel> isItemSaved = ref.watch(savedItemProvider);

    final isSaved = isItemSaved.contains(item);

    final String contains = item.isGlutenFree
        ? "This contains Gluten."
        : "This is Gluten Free food.";
    return Scaffold(
      appBar: AppBar(
        title: Text(
          item.name,
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
        actions: [
          IconButton(
            onPressed: () {
              bool wasSaved = ref
                  .read(savedItemProvider.notifier)
                  .toggleItemsaved(item);
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    wasSaved
                        ? "Item Saved to SavedList!"
                        : "Item Removed from SavedList!",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  elevation: 2,
                  backgroundColor: wasSaved? Colors.green:Colors.red,
                  behavior: SnackBarBehavior.floating,
                  duration: Duration(milliseconds: 200),
                ),
              );
            },
            icon: Icon(
              isSaved ? (Icons.bookmark_add) : (Icons.bookmark_add_outlined),
              color: isSaved ? Colors.red : Colors.white,
              size: 30,
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                item.img,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 250,
              ),
              SizedBox(height: 15),
              Text(
                "Ingridents:",
                style: TextStyle(
                  color: Colors.pink[400],
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: item.ingridents.map((ingredient) {
                  return Text(
                    "• $ingredient",
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  );
                }).toList(),
              ),
              SizedBox(height: 15),
              Text(
                "Steps:",
                style: TextStyle(
                  color: Colors.pink[400],
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: item.steps.map((step) {
                  return Text(
                    "• $step\n",
                    style: const TextStyle(color: Colors.white, fontSize: 15),
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
                  fontWeight: FontWeight.bold,
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
