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
      padding: const EdgeInsets.only(top: 32.0),
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