import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  final int currentIndex; // Add currentIndex parameter

  BottomNavigation({required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex, // Set the currentIndex here
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushNamed(context, '/home'); // Navigate to the home screen
            break;
          case 1:
            Navigator.pushNamed(context, '/statistics'); // Navigate to the statistics screen
            break;
          case 2:
            Navigator.pushNamed(context, '/settings'); // Navigate to the settings screen
            break;
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.insert_chart),
          label: 'Statistics',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    );
  }
}
