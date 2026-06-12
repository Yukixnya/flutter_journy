import 'package:flutter/material.dart' show Color;

class CategoryModel {
  final int id;
  final String title;
  final Color color;

  CategoryModel({
    required this.id,
    required this.title,
    required this.color,
  });
}