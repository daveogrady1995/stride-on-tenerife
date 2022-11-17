import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'itenerary_screen.dart';
import 'map_screen.dart';
import 'package:masterPiece/screens/native_ads_page.dart';

class HomeNavigationScreen extends StatefulWidget {
  @override
  _HomeNavigationScreen createState() => _HomeNavigationScreen();
}

/// This is the private State class that goes with MyStatefulWidget.
class _HomeNavigationScreen extends State<HomeNavigationScreen> {
  int _selectedIndex = 0;
  final List<Widget> _children = [HomeScreen(), ItineraryScreen(), MapScreen()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _children.elementAt(_selectedIndex),
      //body: NativeAdsPage(),
      bottomNavigationBar: Container(
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.wb_sunny_rounded,
              ),
              label: 'Tenerife',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.icecream,
              ),
              label: 'Iteneary',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.map_rounded,
              ),
              label: 'Map',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
