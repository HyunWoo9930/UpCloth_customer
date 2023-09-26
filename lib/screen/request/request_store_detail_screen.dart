import 'package:flutter/material.dart';
import 'package:upcloth/constant/color.dart';
import 'package:upcloth/screen/request/requeset_detail_screen.dart';
import 'package:upcloth/screen/util/util.dart';

class RequestStoreDetailScreen extends StatelessWidget {
  const RequestStoreDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Image(
              image: const AssetImage('asset/img/request_test1.png'),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.4,
              fit: BoxFit.fill,
            ),
            Positioned(
              top: 35,
              left: 20,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.keyboard_arrow_left,
                  color: Colors.white,
                  size: 36,
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: ScrollConfiguration(
            behavior: NoGlowScrollBehavior(),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 24),
                    const Text(
                      '우리동네 수선집',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 12),
                    const Row(
                      children: [
                        StoreTag(text: '수선'),
                        SizedBox(width: 12),
                        StoreTag(text: '리디자인'),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const RequestTextFormWidget(
                        text:
                            '우리동네 수선집! 오래된 옷도 새것처럼. 정성스런 손봉사로 고객님의 마음까지 포근하게 해드립니다. 신뢰와 품질로 대화해요',
                        isTitle: false),
                    const SizedBox(height: 12),
                    const RequestTextFormWidget(text: '영업 시간', isTitle: true),
                    const SizedBox(height: 12),
                    const RequestTextFormWidget(
                        text: '09시 00분 ~ 22시 00분', isTitle: false),
                    const SizedBox(height: 12),
                    const RequestTextFormWidget(text: '휴무일', isTitle: true),
                    const SizedBox(height: 12),
                    const RequestTextFormWidget(text: '매주 일요일', isTitle: false),
                    const SizedBox(height: 12),
                    const RequestTextFormWidget(text: '위치', isTitle: true),
                    const SizedBox(height: 12),
                    const RequestTextFormWidget(
                        text: '서울 구로구 경인로20가길 23 1층', isTitle: false),
                    const SizedBox(height: 12),
                    Container(
                      color: GREY_COLOR,
                      height: 156,
                      child: const Center(child: Text('지도 이미지')),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 32.0,
          width: double.infinity,
          child: TextButton(
            onPressed: () {
              print('의뢰하기 버튼 클릭!!');
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return const RequestDetailScreen();
              }));
            },
            style: TextButton.styleFrom(
                backgroundColor: GREEN_COLOR,
                primary: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0))),
            child: const Text(
              '의뢰하기',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
            ),
          ),
        ),
      ],
    ));
  }
}
