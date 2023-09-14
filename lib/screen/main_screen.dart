import 'package:flutter/material.dart';
import 'package:upcloth/screen/home_screen.dart';
import 'package:upcloth/screen/list_screen.dart';
import 'package:upcloth/screen/mypage_screen.dart';
import 'package:upcloth/screen/new_item_screen.dart';
import 'package:upcloth/screen/search_screen.dart';
import 'package:upcloth/screen/shopping_cart_screen.dart';
import 'package:upcloth/screen/today_recommend_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int _currentIndex = 0;
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
      ListScreen(),
      SearchScreen(),
      HomeScreen(showTodayRecommend: _showTodayRecommend, showNewItem: _showNewItem,),
      MyPageScreen(),
      ShoppingCartScreen(),
      TodayRecommendScreen(),
    ];

    return Scaffold(
      appBar: _appBar(),
      body: showTodayRecommendScreen ? TodayRecommendScreen() : showNewItemScreen ? NewItemScreen() : _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            showTodayRecommendScreen = false;
            showNewItemScreen = false;
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.view_headline_sharp), label: 'list'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'search'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'person'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'shopping_cart'),
        ],
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.black,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}

/// AppBar
PreferredSizeWidget _appBar() {
  return AppBar(
    backgroundColor: Colors.green,
    title: Text('upcloth'),
    centerTitle: true,
  );
}
