import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/models/item_model.dart';
import 'package:recipe_app/providers/saved_provider.dart';
import 'package:recipe_app/widgets/item_card.dart';

class SavedPage extends ConsumerWidget {
  const SavedPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<ItemModel> savedItems = ref.watch(savedItemProvider);

    return Scaffold(
      body: savedItems.isEmpty
          ? const Center(
              child: Text(
                'No saved items yet!',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: savedItems.length,
              itemBuilder: (context, index) {
                return ItemCard(items: savedItems[index]);
              },
            ),
    );
  }
}