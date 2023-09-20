import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constant/color.dart';

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({super.key});

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  double totalPrice = 0.0;

  void updateTotalPrice(double price) {
    setState(() {
      totalPrice = price;
    });
  }

  double getTextWidth(String text, TextStyle style) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr, // 주의: 텍스트 방향은 필요에 따라 설정해야 합니다.
    )..layout(minWidth: 0, maxWidth: double.infinity);

    return textPainter.width;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '합계',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    '${totalPrice.toInt()}₩',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  )
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              SizedBox(
                height: 32.0,
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    print(totalPrice);
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: GREEN_COLOR,
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0))),
                  child: const Text(
                    '구매 하기',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ScrollConfiguration(
            behavior: NoGlowScrollBehavior(),
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
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
                                          '장바구니',
                                          const TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w700)) /
                                      2 +
                                  36 +
                                  40),
                        ),
                        const Text(
                          '장바구니',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 24),
                        ),
                        Spacer()
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 24.0),
                    child: Text(
                      '상품 정보',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                  _Items(
                    path: 'asset/json/shopping_cart.json',
                    onTotalCalculated: updateTotalPrice,
                  ),
                  const SizedBox(height: 12,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Items extends StatefulWidget {
  final String path;
  final Function(double) onTotalCalculated; // 콜백 추가

  const _Items(
      {required this.path, required this.onTotalCalculated, super.key});

  @override
  State<_Items> createState() => _ItemsState();
}

class _ItemsState extends State<_Items> {
  Future<List<dynamic>> loadRecommendItems() async {
    final recommendItemsData = await rootBundle.loadString(widget.path);
    return jsonDecode(recommendItemsData);
  }

  late Future<List<dynamic>> recommendItemsListFuture;

  @override
  void initState() {
    super.initState();
    recommendItemsListFuture = loadRecommendItems();
    recommendItemsListFuture.then((items) {
      double sum = recommendItemsList.fold(0.0, (acc, item) {
        String priceString = item['가격'];
        priceString = priceString.replaceAll('₩', '').replaceAll(',', '');
        return acc + double.parse(priceString);
      });
      widget.onTotalCalculated(sum); // 합계 계산 후 콜백 호출
    });
  }

  late String recommendItemsData;
  late List<dynamic> recommendItemsList = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: recommendItemsListFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          final recommendItemsList = snapshot.data;
          if (recommendItemsList != null) {
            double sum = recommendItemsList.fold(0.0, (acc, item) {
              String priceString = item['가격'];
              priceString = priceString.replaceAll('₩', '').replaceAll(',', '');
              return acc + double.parse(priceString);
            });

            // 합계 계산 후 콜백 호출
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              widget.onTotalCalculated(sum);
            });

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 3,
                    ),
                    itemCount: recommendItemsList.length,
                    itemBuilder: (context, index) {
                      final itemMap =
                          recommendItemsList[index] as Map<String, dynamic>;
                      return Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.0),
                                border:
                                    Border.all(color: Colors.black, width: 0.3),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 0.5,
                                    blurRadius: 1,
                                    offset: const Offset(1, 1),
                                  )
                                ]),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${itemMap['상품명']}',
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.close))
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('가격'),
                                      Text(
                                        '${itemMap['가격']}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('수량'),
                                      Text('${itemMap['수량']} 개',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                          ))
                                    ],
                                  ),
                                ],
                              ),
                            )),
                      );
                    })
              ],
            );
          } else {
            return const Text('data');
          }
        } else {
          return const CircularProgressIndicator(); // 로딩 중을 나타내는 위젯
        }
      },
    );
  }
}

class NoGlowScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context,
      Widget child,
      AxisDirection axisDirection
      ) {
    return child;
  }
}
