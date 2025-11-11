// lib/features/navigation/main_navigation.dart

import 'package:flutter/material.dart';
import 'package:tomoyomu/features/analytics/presentation/pages/analytics_screen.dart';
import 'package:tomoyomu/features/home/presentation/pages/home_screen.dart';
import 'package:tomoyomu/features/manga/presentation/pages/discover_page.dart';
import 'package:tomoyomu/features/profile/presentation/pages/profile_screen.dart';



class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    DiscoverPage(),
    AnalyticsScreen(), // 👈 Classe modifiée
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Découvrir',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_outlined), // 👈 Icône modifiée
            label: 'Analytics', // 👈 Label modifié
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
