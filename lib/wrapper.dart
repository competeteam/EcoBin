import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    const List<BottomNavigationBarItem> navigationBarItems =
        <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          icon: Icon(Icons.menu_book_rounded, size: 25), label: 'Guide'),
      BottomNavigationBarItem(
          icon: Icon(Icons.grid_view_rounded, size: 25),
          label: 'Classification'),
      BottomNavigationBarItem(icon: Icon(Icons.room, size: 30), label: ''),
      BottomNavigationBarItem(
          icon: Icon(Icons.auto_graph_outlined, size: 25), label: 'Calculator'),
      BottomNavigationBarItem(
          icon: Icon(Icons.person, size: 25), label: 'Profile'),
    ];

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF2D2D2D),
        selectedItemColor: const Color(0xFF75BC7B),
        unselectedItemColor: const Color(0xFFD7D7D7),
        currentIndex: navigationShell.currentIndex >= 0 && navigationShell.currentIndex < navigationBarItems.length
          ? navigationShell.currentIndex
          : 0,
        landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
        items: navigationBarItems,
        onTap: _onTap,
      ),
    );
  }

  void _onTap(index) async {
    if (index == 2) {
      await Permission.locationWhenInUse.isDenied.then((valueOfPermission) {
        if (valueOfPermission) {
          Permission.locationWhenInUse.request();
        }
      });
    }
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
