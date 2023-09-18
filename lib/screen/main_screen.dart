import 'package:flutter/material.dart';
import 'package:upcloth/screen/home/home_screen.dart';
import 'package:upcloth/screen/mypage/mypage_screen.dart';
import 'package:upcloth/screen/home/new_item_screen.dart';
import 'package:upcloth/screen/request/request_screen.dart';
import 'package:upcloth/screen/shopping/shopping_screen.dart';
import 'package:upcloth/screen/shoppingCart/shopping_cart_screen.dart';

import 'home/home_screen2.dart';
import 'home/today_recommend_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 2; // 첫 화면을 home_screen으로 설정하기 위함.
  bool showTodayRecommendScreen = false;
  bool showNewItemScreen = false;

  void _showTodayRecommend() {
    setState(() {
      showTodayRecommendScreen = true;
    });
  }

  void _showNewItem() {
    setState(() {
      showNewItemScreen = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      HomeScreen2(
        showTodayRecommend: _showTodayRecommend,
        showNewItem: _showNewItem,),
      ShoppingScreen(),
      RequestScreen(),
      MyPageScreen(),
    ];

    return Scaffold(
      body: showTodayRecommendScreen
          ? TodayRecommendScreen()
          : showNewItemScreen
              ? NewItemScreen()
              : _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            showTodayRecommendScreen = false;
            showNewItemScreen = false;
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_rounded), label: 'list'),
          BottomNavigationBarItem(icon: Icon(Icons.file_copy_rounded), label: 'search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'person'),
        ],
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.black,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}
