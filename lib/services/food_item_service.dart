// services/food_item_service.dart
import 'dart:convert';
import 'package:assignment02/models/category_model.dart';
import 'package:assignment02/models/food_item_model.dart';
import 'package:flutter/services.dart';

class FoodItemService {
  static Future<List<FoodItem>> fetchFoodItemsbyIDs(
      List<String> itemIDs) async {
    final String response =
        await rootBundle.loadString('assets/assignment-dataset.json');
    final data = jsonDecode(response);
    final List foodItems = data['Result']['Items'];
    return foodItems
        .where((item) => itemIDs.contains(item['MenuItemID']))
        .map((item) =>  FoodItem.fromJson(item)).toList();
        
  }
}
