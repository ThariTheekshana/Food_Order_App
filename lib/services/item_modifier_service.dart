// services/item_modifier_service.dart
import 'dart:convert';
import 'package:assignment02/models/category_model.dart';
import 'package:assignment02/models/item_modifier_model.dart';
import 'package:flutter/services.dart';

class ItemModifierService {
  static Future<List<ItemModifierModel>> fetchModifiersByItemId(
      List<String> modifierIds) async {
    final String response =
        await rootBundle.loadString('assets/assignment-dataset.json');
    final data = jsonDecode(response);
    final List modifierGroups = data['Result']['ModifierGroups'];

    return modifierGroups
        .where((modifier) => modifierIds.contains(modifier['ModifierGroupID']))
        .map((modifier){
          return ItemModifierModel.fromJson(modifier);
        }).toList();
        
  }
}
