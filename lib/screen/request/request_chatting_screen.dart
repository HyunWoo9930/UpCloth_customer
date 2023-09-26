import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:upcloth/screen/util/util.dart';

class RequestChattingScreen extends StatefulWidget {
  const RequestChattingScreen({super.key});

  @override
  State<RequestChattingScreen> createState() => _RequestChattingScreenState();
}

class _RequestChattingScreenState extends State<RequestChattingScreen> {
  final TextEditingController _messageController = TextEditingController();

  void _sendMessage() {
    // 메시지를 보내는 로직을 구현하세요.
    String message = _messageController.text;
    if (message.isNotEmpty) {
      // 여기에서 메시지를 전송하거나 처리할 수 있습니다.
      print('보낸 메시지: $message');
      // 메시지를 전송한 후 입력창 비우기
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    var statusBarHeight = MediaQuery.of(context).viewPadding.top;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: statusBarHeight),
        child: Column(
          children: [
            const CustomAppBar(text: '우리동네 수선집'),
            const SizedBox(height: 24),
            Expanded(
              child: ScrollConfiguration(
                behavior: NoGlowScrollBehavior(),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          '의뢰인',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          width: 160,
                          decoration: ShapeDecoration(
                              color: const Color(0xFFEEEEEE),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              )),
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                                '구분\n- 수선\n\n제목\n- 수선할 수 있을까요?\n\n의뢰 내용\n안녕하세요. 찢어진 부분을 수선하고 싶어요',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Inter')),
                          ),
                        ),
                      ),
                      const SizedBox(height: 184),
                      const Text(
                        '우리동네 수선집',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        decoration: ShapeDecoration(
                            color: const Color(0xFFEEEEEE),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            )),
                        child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text('안녕하세요!',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Inter')),
                        ),
                      ),
                      const SizedBox(height: 12)
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Container(
                height: 48,
                child: Expanded(
                  child: TextField(
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w500),
                    controller: _messageController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFF3F3F3),
                      enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide: BorderSide(color: Color(0xFFF3F3F3))),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide: BorderSide(color: Color(0xFFF3F3F3))),
                      suffixIcon: IconButton(
                          onPressed: _sendMessage,
                          icon: SvgPicture.asset('asset/icon/chat.svg',
                              color: Colors.black, height: 24, width: 24)),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
