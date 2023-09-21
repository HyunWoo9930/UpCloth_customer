import 'package:flutter/material.dart';
import 'package:upcloth/screen/mypage/order_details_screen.dart';
import 'package:upcloth/screen/shopping/shopping_cart_screen.dart';
import 'package:upcloth/screen/util/util.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const CustomAppBar(text: '주문 목록'),
              const SizedBox(
                height: 36,
              ),
              _orderList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _orderList() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0.5,
            blurRadius: 1,
            offset: const Offset(1, 1),
          )
        ],
      ),
      child: TextButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return OrderDetailScreen();
            }));
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 12.0),
                  child: Text(
                    '[2PACK] 에어쿨링 드라이 기능성 무지 반팔티, [SET UP] 에어쿨링 드라이브 기능성 반팔티+반바지 세트',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '주문 날짜',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '2023.09.01',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '결제 금액',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '30,000₩',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
              ],
            ),
          )),
    );
  }
}
