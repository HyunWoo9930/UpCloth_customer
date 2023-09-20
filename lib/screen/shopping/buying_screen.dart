import 'package:flutter/material.dart';
import 'package:upcloth/screen/util/util.dart';

import '../../constant/color.dart';

class BuyingScreen extends StatefulWidget {
  const BuyingScreen({super.key});

  @override
  State<BuyingScreen> createState() => _BuyingScreenState();
}

class _BuyingScreenState extends State<BuyingScreen> {
  double totalPrice = 0.0;
  final _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ScrollConfiguration(
            behavior: NoGlowScrollBehavior(),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomAppBar(text: '구매하기'),
                  const Padding(
                    padding: EdgeInsets.only(top: 24.0),
                    child: Text(
                      '상품 정보',
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                  ),
                  _Items(path: 'asset/json/shopping_cart.json', onTotalCalculated: updateTotalPrice,),
                  const Padding(
                    padding: EdgeInsets.only(top: 24.0, bottom: 12.0),
                    child: Text(
                      '배송 정보',
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 12.0, left: 12.0),
                            child: Text(
                              '주소',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w700),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 12.04, left: 7.0, right: 6.0),
                            child: TextField(
                              controller: _addressController,
                              decoration: const InputDecoration(
                                filled: false,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: GREY_COLOR)
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: GREEN_COLOR)
                                )
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
                      child: Padding(
                        padding: const EdgeInsets.only(
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
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    color: Colors.white,
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
                              print('구매하기 버튼 클릭!!');
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
                        const SizedBox(height: 12,)
                      ],
                    ),
                  )
                ],
              ),
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
                        padding: const EdgeInsets.only(top: 12.0, left: 2, right: 2),
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
