import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:login_app/components/home_screen_components.dart';
import 'package:login_app/screens/order_screen.dart';
import 'package:login_app/screens/profile_screen.dart';
import 'package:modern_form_line_awesome_icons/modern_form_line_awesome_icons.dart';

import 'login_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  static String id = 'welcome_screen';

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int index = 0;
  int _selectedIndex = 0;
  int _bottomNavIndex = 0;
  PageController _pageController = PageController();

  List<IconData> iconList = [
    //list of icons that required by animated navigation bar.
    Icons.home,
    Icons.shopping_cart,
    Icons.person,

  ];

  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          HomeScreenComponent(),
          Order_Page(),
          ProfilePage(),
        ],
        onPageChanged: (index) {
          setState(() {
            _bottomNavIndex = index;
          });
        },
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
      //     BottomNavigationBarItem(icon: Icon(Icons.work), label: "Order"),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.face),
      //       label: "Profile",
      //     ),
      //   ],
      //   currentIndex: index,
      //   onTap: _onTapItem,
      //   fixedColor: Colors.blue,
      // ),
      bottomNavigationBar: AnimatedBottomNavigationBar(
          icons: iconList,
          activeIndex: _bottomNavIndex,
          gapLocation: GapLocation.none,
          notchSmoothness: NotchSmoothness.smoothEdge,
          // onTap: (index) => setState(() => _bottomNavIndex = index),
          onTap: (index) {
            setState(() {
              _bottomNavIndex = index;
              _pageController.animateToPage(index,
                  duration: Duration(milliseconds: 300), curve: Curves.ease);
            });
          } //other params
      ),
    );
  }


  void _onTapItem(int index) {
    setState(() {
      _selectedIndex = index;
      switch (_selectedIndex) {
        case 0:
          Navigator.pushNamed(context, DashboardScreen.id);
          break;
        case 1:
          Navigator.pushNamed(context, Order_Page.id);
          break;
        case 2:
          Navigator.pushNamed(context, ProfilePage.id);
          break;
      }
    });
  }
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}