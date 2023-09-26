import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

double getTextWidth(String text, TextStyle style) {
  final textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    maxLines: 1,
    textDirection: TextDirection.ltr,
  )..layout(minWidth: 0, maxWidth: double.infinity);

  return textPainter.width;
}

class CustomAppBar extends StatefulWidget {
  final String text;

  const CustomAppBar({required this.text, super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 35.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.keyboard_arrow_left,
              color: Colors.black,
              size: 36,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2 -
                (getTextWidth(
                            widget.text,
                            const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w700)) /
                        2 +
                    36 +
                    40),
          ),
          Text(
            widget.text,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
          ),
        ],
      ),
    );
  }
}

Future<List<dynamic>> loadJsonFromPath(String path) async {
  final data = await rootBundle.loadString(path);
  return jsonDecode(data);
}

class NoGlowScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

BoxDecoration whiteContainerDecoration() {
  return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 0.5,
          blurRadius: 1,
          offset: const Offset(1, 1),
        ),
      ]);
}

class StoreTag extends StatelessWidget {
  final String text;

  const StoreTag({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 16,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
          '리디자인',
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontFamily: 'Inter',
              fontSize: 6,
              color: Colors.black),
        ),
      ),
    );
  }
}

class RequestTextFormWidget extends StatelessWidget {
  final String text;
  final bool isTitle;

  const RequestTextFormWidget({super.key, required this.text, required this.isTitle});

  final TextStyle titleStyleForm = const TextStyle(
      color: Colors.black,
      fontSize: 12,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w700);
  final TextStyle bodyStyleForm = const TextStyle(
      color: Color(0xFF838383),
      fontSize: 10,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w500);

  @override
  Widget build(BuildContext context) {
    if (isTitle) {
      return Text(
        text,
        style: titleStyleForm,
      );
    } else {
      return Text(
        text,
        style: bodyStyleForm,
      );
    }
  }
}