// services/category_services.dart
import 'dart:convert';
import 'package:assignment02/models/category_model.dart';
import 'package:flutter/services.dart';

class CategoryServices {
  static Future<List<MenuCategory>> fetchCategoriesByMenuCategoryIds(
      List<String> categoryIds) async {
    final String response =
        await rootBundle.loadString('assets/assignment-dataset.json');
    final data = jsonDecode(response);
    final List categories = data['Result']['Categories'];
    return categories
        .where((category) => categoryIds.contains(category['MenuCategoryID']))
        .map((category) =>  MenuCategory.fromJson(category)).toList();
        
  }
}
