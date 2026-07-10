import 'dart:io' show File;

class FavModel{
  final String id;
  final File image;
  final String name;
  final String desc;

  FavModel({
    required this.id,
    required this.image,
    required this.name,
    required this.desc,
  });
}