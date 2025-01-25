// services/menu_services.dart
import 'dart:convert';
import 'package:assignment02/models/menu_model.dart';
import 'package:flutter/services.dart';

class MenuServices {
  static Future<List<Menu>> fetchMenus() async {
    final String response =
        await rootBundle.loadString('assets/assignment-dataset.json');
    final data = jsonDecode(response);
    final List menus = data['Result']['Menu'];
    return menus.map((menu) => Menu.fromJson(menu)).toList();
  }

  static Future<Menu> fetchMenuByMenuId(String menuId) async {
    final String response =
        await rootBundle.loadString('assets/assignment-dataset.json');
    final data = jsonDecode(response);
    final List menus = data['Result']['Menu'];
    Map<String, dynamic> menu =
        menus.firstWhere((menu) => menu['MenuID'] == menuId);
    return Menu.fromJson(menu);
  }
}
