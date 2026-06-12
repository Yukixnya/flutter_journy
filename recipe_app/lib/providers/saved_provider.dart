import 'package:flutter_riverpod/legacy.dart';
import 'package:recipe_app/models/item_model.dart';

class ItemSavedNotifier extends StateNotifier<List<ItemModel>>{
  ItemSavedNotifier() : super([]);

  bool toggleItemsaved(ItemModel item){
    bool isItemSaved = state.contains(item);
    if(isItemSaved){
      state = state.where((i)=>i != item).toList();
      return false;
    }
    else{
      state = [...state,item];
      return true;
    }
  }
}

final savedItemProvider = StateNotifierProvider<ItemSavedNotifier,List<ItemModel>>((ref) {
  return ItemSavedNotifier();
});