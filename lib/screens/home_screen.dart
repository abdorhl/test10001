// import 'package:flutter/material.dart';
// // import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int _selectedIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Google Bottom Bar')),
//       body: Center(
//         child: _navBarItems[_selectedIndex].title,
//       ),
//       bottomNavigationBar: SalomonBottomBar(
//           currentIndex: _selectedIndex,
//           selectedItemColor: const Color(0xff6200ee),
//           unselectedItemColor: const Color(0xff757575),
//           onTap: (index) {
//             setState(() {
//               _selectedIndex = index;
//             });
//           },
//           items: _navBarItems),
//     );
//   }
// }

// final _navBarItems = [
//   SalomonBottomBarItem(
//     icon: const Icon(Icons.home),
//     title: const Text("Home"),
//     selectedColor: const Color(0xFFD29E1A),
//   ),
//   SalomonBottomBarItem(
//     icon: const Icon(Icons.more),
//     title: const Text("More"),
//     selectedColor: const Color(0xFFD29E1A),
//   ),
//   SalomonBottomBarItem(
//     icon: const Icon(Icons.search),
//     title: const Text("Search"),
//     selectedColor: const Color(0xFFD29E1A),
//   ),
//   SalomonBottomBarItem(
//     icon: const Icon(Icons.settings),
//     title: const Text("Settings"),
//     selectedColor: const Color(0xFFD29E1A),
//   ),
// ];
