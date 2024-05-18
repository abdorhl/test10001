import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:test2figma/nav_bar/home.dart';
import 'package:test2figma/nav_bar/search.dart';
import 'package:test2figma/nav_bar/more.dart';
import 'package:test2figma/nav_bar/setting.dart';

class MyBottomNavBar extends StatefulWidget {
  const MyBottomNavBar({super.key});

  @override
  State<MyBottomNavBar> createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
  int myCurrentIndex = 0;

  // Define _onAppSelected function
  void _onAppSelected(String app) {
    setState(() {
      myCurrentIndex = 0; // Assuming you want to navigate back to the HomePage after app selection
      // You may have a different logic here to handle navigation or updating state
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      const HomePage(),
      const FavoritePage(), // Ensure this is the correct constructor
      const SettingsPage(),
      const MorePage(),
    ];

    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(75), // Apply border-radius
          // Apply background color
        ),
        height: 80, // Apply height
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: const Color.fromARGB(255, 255, 255, 255),
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: const Color.fromRGBO(210, 158, 26, 1),
              color: Colors.black,
              tabs: const [
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: LineIcons.search,
                  text: 'Search',
                ),
                GButton(
                  icon: LineIcons.cog,
                  text: 'Settings',
                ),
                GButton(
                  icon: LineIcons.magic,
                  text: 'More',
                ),
              ],
              selectedIndex: myCurrentIndex,
              onTabChange: (index) {
                setState(() {
                  myCurrentIndex = index;
                });
              },
            ),
          ),
        ),
      ),
      body: pages[myCurrentIndex],
    );
  }
}
