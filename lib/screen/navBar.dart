import 'package:cryptoapp/screen/homepage.dart';
import 'package:flutter/material.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int currentIndex = 0;
  List<Widget> pages = [Homepage(), Homepage(), Homepage(), Homepage()];
  @override
  Widget build(BuildContext context) {
    // double myWidth = MediaQuery.of(context).size.width;
    // double myHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: pages.elementAt(currentIndex),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.grey,
        onTap:
            (value) => {
              setState(() {
                currentIndex = value;
              }),
            },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.notification_add),
            label: 'Home',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Home'),
        ],
      ),
    );
  }
}
