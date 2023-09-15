import 'package:flutter/material.dart';
import 'package:upcloth/screen/home/home_screen.dart';
import 'package:upcloth/screen/list/list_screen.dart';
import 'package:upcloth/screen/mypage/mypage_screen.dart';
import 'package:upcloth/screen/home/new_item_screen.dart';
import 'package:upcloth/screen/search/search_screen.dart';
import 'package:upcloth/screen/shoppingCart/shopping_cart_screen.dart';

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
      ListScreen(),
      SearchScreen(),
      HomeScreen(
        showTodayRecommend: _showTodayRecommend,
        showNewItem: _showNewItem,
      ),
      MyPageScreen(),
      ShoppingCartScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('upcloth'),
        centerTitle: true,
        leading: showTodayRecommendScreen // 오늘의 추천 더보기 가 켜져있을때, 뒤로가기를 누르면 false
            ? IconButton(
                onPressed: () {
                  setState(() {
                    showTodayRecommendScreen = false;
                  });
                },
                icon: Icon(Icons.arrow_back))
            : showNewItemScreen
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showTodayRecommendScreen = false;
                      });
                    },
                    icon: Icon(Icons.arrow_back))
                : null,
      ),
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
