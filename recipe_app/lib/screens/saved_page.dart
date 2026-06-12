import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/models/item_model.dart';
import 'package:recipe_app/providers/saved_provider.dart';

class SavedPage extends ConsumerWidget {
  const SavedPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<ItemModel> savedItems = ref.watch(
      savedItemProvider
    );
    return Scaffold(
      body: Center(
        child: Text(savedItems[0].name,style: TextStyle(color:Colors.white),),
      ),
    );
  }
}