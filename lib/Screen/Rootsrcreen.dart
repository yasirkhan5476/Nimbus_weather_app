import 'package:flutter/material.dart';
import 'package:minbus_weather_app/Screen/Explore_screen.dart';

class Rootsrcreen extends StatefulWidget {
  const Rootsrcreen({super.key});

  @override
  State<Rootsrcreen> createState() => _RootsrcreenState();
}

class _RootsrcreenState extends State<Rootsrcreen> {
  int _currentIndex = 0;

  // Define your screen views here
  final List<Widget> _pages = [
   ExploreScreen(),
    Center(child: Text("Expenses Screen")),
    Center(child: Text("Student Todo Screen")),
    Center(child: Text("Settings / Profile Screen")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // IndexedStack keeps screen state alive when switching tabs
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF2F6BFF), // Accent blue
        unselectedItemColor: Colors.grey.shade500,
        showUnselectedLabels: true,
        elevation: 8,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_outlined),
            activeIcon: Icon(Icons.account_balance_wallet),
            label: "Expenses",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school_outlined),
            activeIcon: Icon(Icons.school),
            label: "Students",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}