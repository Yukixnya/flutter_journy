import 'package:assingment12/models/fav_model.dart';
import 'package:flutter_riverpod/legacy.dart';

class FavNotifier extends StateNotifier<List<FavModel>> {
  FavNotifier() : super([]);

  void addFav(FavModel favModel) {
    state = [...state, favModel];
  }

  void removeFav(FavModel favModel) {
    state = state.where((fav) => fav.id != favModel.id).toList();
  }

  List<FavModel> getFavs() {
    return List.from(state);
  }
}

final favProvider = StateNotifierProvider<FavNotifier, List<FavModel>>(
  (ref) => FavNotifier(),
);
