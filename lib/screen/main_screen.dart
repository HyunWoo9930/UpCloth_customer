import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:upcloth/screen/home/home_screen.dart';
import 'package:upcloth/screen/mypage/mypage_screen.dart';
import 'package:upcloth/screen/home/new_item_screen.dart';
import 'package:upcloth/screen/request/request_screen.dart';
import 'package:upcloth/screen/shopping/shopping_screen.dart';

import 'home/today_recommend_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Future<bool> _onBackPressed() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('앱을 종료하시겠습니까?'),
        actions: <Widget>[
          TextButton(
            child: Text('아니오'),
            onPressed: () {
              Navigator.of(context).pop(false); // 다이얼로그를 닫고 false 값을 반환합니다.
            },
          ),
          TextButton(
            child: Text('예'),
            onPressed: () {
              Navigator.of(context).pop(true); // 다이얼로그를 닫고 true 값을 반환합니다.
            },
          ),
        ],
      ),
    ) ?? false; // showDialog가 null을 반환할 경우 false를 반환합니다.
  }

  int _currentIndex = 0; // 첫 화면을 home_screen으로 설정하기 위함.
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

  void onItemClicked(int index) {
    setState(() {
      showTodayRecommendScreen = false;
      showNewItemScreen = false;
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      HomeScreen(
        showTodayRecommend: _showTodayRecommend,
        showNewItem: _showNewItem,
      ),
      ShoppingScreen(),
      RequestScreen(),
      MyPageScreen(),
    ];

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        body: showTodayRecommendScreen
            ? ShoppingScreen()
            : showNewItemScreen
                ? ShoppingScreen()
                : _screens[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            onItemClicked(index);
          },
          items: [
            BottomNavigationBarItem(
              label: 'home',
              icon: SvgPicture.asset('asset/icon/home.svg', color: _currentIndex == 0 ? Color(0xFF1EA43B) : Color(0xFF888888)),
            ),
            BottomNavigationBarItem(
              label: 'list',
              icon: SvgPicture.asset('asset/icon/list.svg', color: _currentIndex == 1 ? Color(0xFF1EA43B) : Color(0xFF888888)),
            ),
            BottomNavigationBarItem(
              label: 'search',
              icon: SvgPicture.asset('asset/icon/search.svg', color: _currentIndex == 2 ? Color(0xFF1EA43B) : Color(0xFF888888)),
            ),
            BottomNavigationBarItem(
              label: 'person',
              icon: SvgPicture.asset('asset/icon/person.svg', color: _currentIndex == 3 ? Color(0xFF1EA43B) : Color(0xFF888888)),
            ),
          ],
          showSelectedLabels: false,
          showUnselectedLabels: false,
        ),
      ),
    );
  }
}
