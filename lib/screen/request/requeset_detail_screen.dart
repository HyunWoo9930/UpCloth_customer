import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:upcloth/screen/request/request_chatting_screen.dart';
import 'package:upcloth/screen/util/util.dart';

class RequestDetailScreen extends StatefulWidget {
  const RequestDetailScreen({super.key});

  @override
  State<RequestDetailScreen> createState() => _RequestDetailScreenState();
}

class _RequestDetailScreenState extends State<RequestDetailScreen> {
  int selectedContainerIndex = -1;
  List<bool> containerStates = [false, false, false];
  List<String> tagMessage = ['수선', '리폼', '리디자인'];

  @override
  Widget build(BuildContext context) {
    var statusBarHeight = MediaQuery.of(context).viewPadding.top;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: statusBarHeight),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomAppBar(text: '상품의뢰'),
            Expanded(
                child: ScrollConfiguration(
              behavior: NoGlowScrollBehavior(),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    const Text(
                      '가게정보',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Inter',
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      '우리동네 수선집',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Inter',
                        color: Color(0xFF888888),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      '사진등록',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Inter',
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 128,
                      child: TextButton(
                        onPressed: () {
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: const Color(0xFFF3F3F3),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                        child: const Center(
                          child: Text(
                            '+ 터치하여 사진을 등록해 주세요',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Inter'),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      '구분',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Inter',
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        for (int i = 0; i < 3; i++)
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedContainerIndex = i;
                                  for (int j = 0; j < 3; j++) {
                                    containerStates[j] = (j == i);
                                  }
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: Container(
                                  height: 32,
                                  width: 74,
                                  decoration: ShapeDecoration(
                                    color: containerStates[i]
                                        ? Colors.green
                                        : Colors.white,
                                    // 선택된 Container는 초록색, 나머지는 하얀색
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
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
                                    child: Text(
                                      tagMessage[i],
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'Inter',
                                        color: containerStates[i]
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ))
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      '제목',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Inter',
                      ),
                    ),
                    const TextField(
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      '의뢰내용',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Inter',
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 0.50, color: const Color(0xFF888888)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            border: InputBorder.none
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 90),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12, bottom: 12),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                              return const RequestChattingScreen();
                            }));
                          },
                          child: Container(
                            width: 64,
                            height: 64,
                            decoration: const ShapeDecoration(
                              color: Colors.white,
                              shape: OvalBorder(),
                              shadows: [
                                BoxShadow(
                                  color: Color(0x3F000000),
                                  blurRadius: 4,
                                  offset: Offset(4, 4),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            child: Center(
                                child: SvgPicture.asset(
                              'asset/icon/chat.svg',
                              height: 32,
                              width: 32,
                              fit: BoxFit.contain,
                            )),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
