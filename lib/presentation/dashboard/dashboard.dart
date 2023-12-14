import 'package:flutter/material.dart';

import 'dashboard_pages/home.dart';
import 'dashboard_pages/OrderPage.dart';
import 'dashboard_pages/profile.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    Home(),
    OrderPage(data: {},),
    Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _pages[_currentIndex],
      // Set the background color here
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          // Update the selected index when a tab is pressed
          setState(() {
            _currentIndex = index;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),backgroundColor: Colors.black,
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.opacity_rounded),
            label: 'Order',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Profile',
          ),


        ],
        selectedItemColor: Color(0xFF0D4619),
      ),

    );
  }
}
