// routes/router.dart
import 'package:assignment02/models/menu_model.dart';
import 'package:assignment02/services/menu_services.dart';
import 'package:assignment02/views/category_screen.dart';
import 'package:assignment02/views/menu_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/menu',
    routes: [
      GoRoute(
        path: '/menu',
        builder: (context, state) {
          return FutureBuilder<List<Menu>>(
            future: MenuServices.fetchMenus(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                return MenuScreen(menus: snapshot.data!);
              } else {
                return const Center(child: Text('No data found'));
              }
            },
          );
        },
      ),
      GoRoute(path: '/category', builder: (context, state) => const CatergotyScreen(menuID: '',)),
    
    ],
  );
}
