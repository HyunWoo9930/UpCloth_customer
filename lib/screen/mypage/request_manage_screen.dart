import 'package:flutter/material.dart';
import 'package:upcloth/screen/util/util.dart';

class RequestManageScreen extends StatefulWidget {
  const RequestManageScreen({super.key});

  @override
  State<RequestManageScreen> createState() => _RequestManageScreenState();
}

class _RequestManageScreenState extends State<RequestManageScreen> {
  //TODO 의뢰 관리 데이터로 가게명, 최신 채팅, 안읽은 문자 개수 표시 - 현재 고정값
  //TODO 의뢰 관리 개수를 map으로 TextButton 만들기 - 현재 Container

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const CustomAppBar(text: '의뢰 관리'),
            const SizedBox(
              height: 40,
            ),
            _chatting(),
          ],
        ),
      ),
    );
  }

  Widget _chatting() {
    return Container(
      decoration: whiteContainerDecoration(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 12.0, bottom: 13.0),
                  child: Text(
                    '우리동네 수선집',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 12.0),
                  child: Text(
                    '안녕하세요!',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                )
              ],
            ),
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF1EA43B),
              ),
              width: 18.0,
              height: 18.0,
              child: const Center(
                child: Text(
                  '1',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 8,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
