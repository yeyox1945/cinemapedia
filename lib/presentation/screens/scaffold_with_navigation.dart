import 'package:cupertino_native_better/cupertino_native.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNavigation extends StatelessWidget {
  const ScaffoldWithNavigation({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  void _onTap(int value) => navigationShell.goBranch(value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      extendBody: true,
      bottomNavigationBar: CNTabBar(
          items: const [
            CNTabBarItem(
              label: 'Inicio',
              icon: CNSymbol('house'),
            ),
            CNTabBarItem(
              label: 'Favoritos', 
              icon: CNSymbol('heart'),
            ),
          ], 
        currentIndex: navigationShell.currentIndex, 
        onTap: _onTap,
       ),
    );
  }
}
