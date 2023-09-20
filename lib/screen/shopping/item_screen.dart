import 'package:flutter/material.dart';
import 'package:upcloth/constant/color.dart';
import 'package:upcloth/screen/shopping/shopping_screen.dart';
import 'package:upcloth/screen/shopping/shopping_cart_screen.dart';

class ItemScreen extends StatefulWidget {
  final Map<String, dynamic> itemMap;

  const ItemScreen({required this.itemMap, super.key});

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SizedBox(
            height: 32.0,
            width: double.infinity,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) {
                    return ShoppingCartScreen();
                  })
                );
                print("장바구니 클릭!!");
              },
              style: TextButton.styleFrom(
                  backgroundColor: GREEN_COLOR,
                  primary: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0))),
              child: Text(
                '장바구니',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
              ),
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                // 이미지
                height: screenHeight / 2,
                width: screenWidth,
                child: Stack(fit: StackFit.expand, children: [
                  Image.asset(
                    'asset/img/${widget.itemMap["이미지"]}',
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 32.0, // 아이콘의 상단 위치를 조정하세요.
                    left: 20.0, // 아이콘의 왼쪽 위치를 조정하세요.
                    child: IconButton(
                      icon: const Icon(
                        Icons.keyboard_arrow_left,
                      ),
                      iconSize: 32.0,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  )
                ])),
            Padding(
              // 상품명, 가격
              padding: const EdgeInsets.only(left: 20.0, right: 20, top: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${widget.itemMap['상품명']}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  Text('${widget.itemMap['가격']}',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 20),
                  child: Container(
                    child: Text(
                      '대분류 > 소분류',
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 8),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(color: Colors.black, width: 0.3),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 0.5,
                            blurRadius: 1,
                            offset: Offset(1, 1),
                          )
                        ]),
                  ),
                ),
              ],
            ),
            Padding(
              // 가게 설명, 판매사
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.itemMap["가게설명"],
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF838383)),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    '판매사',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    widget.itemMap["가게명"],
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF888888)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
