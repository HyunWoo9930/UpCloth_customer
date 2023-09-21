import 'package:flutter/material.dart';
import 'package:upcloth/screen/util/util.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});

  // TODO 향후 개인정보데이터 이용하여, 이름/이메일 변경 필요.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overscroll) {
            overscroll.disallowIndicator();
            return true;
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomAppBar(text: '마이 페이지'),
                const SizedBox(
                  height: 24,
                ),
                _headers(),
                const Padding(
                  padding: EdgeInsets.only(top: 36.0, bottom: 12.0),
                  child: Text(
                    '설정',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                    ),
                  ),
                ),
                _settings(),
                const Padding(
                  padding: EdgeInsets.only(top: 24.0, bottom: 12.0),
                  child: Text(
                    '기타',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                    ),
                  ),
                ),
                _etc(),
                _version('v0.0.1'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _settingTextButton(String name, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
          padding: EdgeInsets.only(top: 12, left: 36, bottom: 12)),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          name,
          style: const TextStyle(fontSize: 14, color: Colors.black),
        ),
      ),
    );
  }

  Padding _line() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        width: double.infinity,
        height: 1,
        color: const Color(0xFFDDDDDD),
      ),
    );
  }

  Widget _headers() {
    return Container(
      decoration: whiteContainerDecoration(),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 8.0, bottom: 8.0, left: 20.0, right: 12),
            child: Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage('asset/img/test1.jpeg'))),
              width: 64,
              height: 64,
            ),
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'rlarl7477',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                'rlarl7477@atlasnetworks.co.kr',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Color(0xFF888888)),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _settings() {
    return Container(
      decoration: whiteContainerDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _settingTextButton('프로필 수정', () {}),
          _line(),
          _settingTextButton('의뢰 관리', () {}),
          _line(),
          _settingTextButton('장바구니', () {}),
          _line(),
          _settingTextButton('주문 목록', () {}),
          _line(),
          _settingTextButton('고객 센터', () {})
        ],
      ),
    );
  }

  Widget _etc() {
    return Container(
      decoration: whiteContainerDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _settingTextButton('고객센터', () {}),
          _line(),
          _settingTextButton('공지사항', () {}),
          _line(),
          _settingTextButton('약관 및 정책', () {}),
        ],
      ),
    );
  }

  Widget _version(String version) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 24.0),
        child: Text(
          version,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: Color(0xFF888888),
          ),
        ),
      ),
    );
  }
}
