import 'package:flutter/material.dart';
import 'package:upcloth/screen/login_screen_customer.dart';
import 'package:upcloth/screen/request/request_detail_screen.dart';
import 'package:upcloth/screen/util/util.dart';

class StoreListScreen extends StatefulWidget {
  final Map<String, dynamic> data;

  const StoreListScreen({super.key, required this.data});

  @override
  State<StoreListScreen> createState() => _StoreListScreenState();
}

class _StoreListScreenState extends State<StoreListScreen> {
  @override
  Widget build(BuildContext context) {
    var statusBarHeight = MediaQuery.of(context).viewPadding.top;
    String? regionName = widget.data["시/도"]["이름"];
    String? cityName = widget.data["시/도"]["시/군/구"]["이름"];
    String? neighborhoodName = widget.data["시/도"]["시/군/구"]["읍/면/동"]["이름"];
    String location = "";
    if (regionName != null) {
      if (cityName != null) {
        if (neighborhoodName != null) {
          location = "$regionName > $cityName > $neighborhoodName";
        } else {
          location = "$regionName > $cityName";
        }
      } else {
        location = regionName;
      }
    }
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: statusBarHeight),
        child: Column(children: [
          const SizedBox(
            height: 10,
          ),
          const CustomAppBar(text: '상품의뢰'),
          const SizedBox(
            height: 24,
          ),
          Row(
            children: [
              Container(
                height: 32,
                decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    shadows: const [
                      BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 4,
                          offset: Offset(1, 1),
                          spreadRadius: 0)
                    ]),
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    location,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        fontFamily: 'Inter'),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  GestureDetector(
                    onTap:() {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                        return RequestDetailScreen();
                      }));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: Container(
                        width: double.infinity,
                        height: 260,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Image.asset(
                                'asset/img/request_test1.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 8, right: 22),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    '우리동네 수선집',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(top: 12, bottom: 8),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 40,
                                          height: 16,
                                          decoration: ShapeDecoration(
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            shadows: const [
                                              BoxShadow(
                                                color: Color(0x3F000000),
                                                blurRadius: 4,
                                                offset: Offset(1, 1),
                                                spreadRadius: 0,
                                              )
                                            ],
                                          ),
                                          child: const Center(
                                            child: Text(
                                              '수선',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: 'Inter',
                                                  fontSize: 6,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Container(
                                          width: 40,
                                          height: 16,
                                          decoration: ShapeDecoration(
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            shadows: const [
                                              BoxShadow(
                                                color: Color(0x3F000000),
                                                blurRadius: 4,
                                                offset: Offset(1, 1),
                                                spreadRadius: 0,
                                              )
                                            ],
                                          ),
                                          child: Center(
                                            child: const Text(
                                              '리디자인',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: 'Inter',
                                                  fontSize: 6,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Text(
                                    '우리동네 수선집! 오래된 옷도 새것처럼. 정성스런 손봉사로 고객님의 마음까지 포근하게 해드립니다. 신뢰와 품질로 대화해요',
                                    style: TextStyle(
                                        color: Color(0xFF838383),
                                        fontSize: 10,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                        return RequestDetailScreen();
                      }));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: Container(
                        width: double.infinity,
                        height: 260,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Image.asset(
                                'asset/img/request_test2.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 8, right: 22),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    '업클로스',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(top: 12, bottom: 8),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 40,
                                          height: 16,
                                          decoration: ShapeDecoration(
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(12)),
                                            shadows: const [
                                              BoxShadow(
                                                color: Color(0x3F000000),
                                                blurRadius: 4,
                                                offset: Offset(1, 1),
                                                spreadRadius: 0,
                                              )
                                            ],
                                          ),
                                          child: const Center(
                                            child: Text(
                                              '수선',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: 'Inter',
                                                  fontSize: 6,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Container(
                                          width: 40,
                                          height: 16,
                                          decoration: ShapeDecoration(
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(12)),
                                            shadows: const [
                                              BoxShadow(
                                                color: Color(0x3F000000),
                                                blurRadius: 4,
                                                offset: Offset(1, 1),
                                                spreadRadius: 0,
                                              )
                                            ],
                                          ),
                                          child: Center(
                                            child: const Text(
                                              '리디자인',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: 'Inter',
                                                  fontSize: 6,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Text(
                                    '우리동네 수선집! 오래된 옷도 새것처럼. 정성스런 손봉사로 고객님의 마음까지 포근하게 해드립니다. 신뢰와 품질로 대화해요',
                                    style: TextStyle(
                                        color: Color(0xFF838383),
                                        fontSize: 10,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: Container(
                      width: double.infinity,
                      height: 260,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
