import 'package:flutter/material.dart';
import 'package:upcloth/screen/util/util.dart';

import '../../constant/color.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  double totalPrice = 0.0;
  final _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ScrollConfiguration(
          behavior: NoGlowScrollBehavior(),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
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
                                        '주문 상세 정보',
                                        const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w700)) /
                                    2 +
                                36 +
                                40),
                      ),
                      const Text(
                        '주문 상세 정보',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 24),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 24.0),
                  child: Text(
                    '상품 정보',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                ),
                _Items(
                  path: 'asset/json/shopping_cart.json',
                  onTotalCalculated: updateTotalPrice,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 24.0, bottom: 12.0),
                  child: Text(
                    '배송 정보',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 0.5,
                            blurRadius: 1,
                            offset: const Offset(1, 1),
                          )
                        ]),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 12.0, left: 12.0),
                          child: Text(
                            '주소',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w700),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: 12, left: 12.0, right: 6.0, top: 12.0),
                          child: Text(
                            '서울특별시 중구 회현동1가 147-27',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF888888),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 24.0, bottom: 12.0),
                  child: Text(
                    '결제 정보',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 0.5,
                            blurRadius: 1,
                            offset: const Offset(1, 1),
                          )
                        ]),
                    child: const Padding(
                      padding: EdgeInsets.only(
                          top: 15.0, left: 12.0, bottom: 14.0, right: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.radio_button_checked,
                            size: 12,
                          ),
                          Text(
                            '일반 결제',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 14),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 292,
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
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void updateTotalPrice(double price) {
    setState(() {
      totalPrice = price;
    });
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
  late Future<List<dynamic>> recommendItemsListFuture;

  @override
  void initState() {
    super.initState();
    recommendItemsListFuture = loadJsonFromPath(widget.path);
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
                        padding:
                            const EdgeInsets.only(top: 12.0, left: 2, right: 2),
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.0),
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
