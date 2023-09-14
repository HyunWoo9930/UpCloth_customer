import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewItemScreen extends StatefulWidget {
  const NewItemScreen({super.key});

  @override
  State<NewItemScreen> createState() => _NewItemScreenState();
}

class _NewItemScreenState extends State<NewItemScreen> {
  Future<void> loadRecommendItems() async {
    recommendItemsData = await getItems();
    recommendItemsList = jsonDecode(recommendItemsData);
    setState(() {});
  }

  int _pageIndex = 0;
  late String recommendItemsData;
  late List<dynamic> recommendItemsList =
  []; // 값을 저장할 변수를 List<dynamic> 타입으로 선언합니다.

  @override
  void initState() {
    super.initState();
    loadRecommendItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('upcloth'),
        centerTitle: true,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.grey, width: 1.0))),
        child: BottomNavigationBar(
          onTap: (value) {
            setState(() {
              _pageIndex = value;
            });
          },
          currentIndex: _pageIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black,
          type: BottomNavigationBarType.shifting,
          showSelectedLabels: false,
          // 선택된 라벨 보이기/숨기기
          showUnselectedLabels: false,
          // 선택되지 않은 라벨 보이기/숨기기
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.view_headline_sharp), label: 'list'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'search'),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'myPage'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), label: 'cart'),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16.0, top: 10),
            child: Text(
              '신규 아이템',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1, // 1:1 비율로 정사각형 형태로 만듭니다.
              ),
              itemCount: recommendItemsList.length,
              itemBuilder: (context, index) {
                final itemMap =
                recommendItemsList[index] as Map<String, dynamic>;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      print("${itemMap["상품명"]} 버튼 클릭");
                    },
                    child: Column(
                      children: [
                        Expanded(
                          // Expanded를 사용하여 이미지가 할당된 공간 내에 들어가도록 합니다.
                          child: Image.asset(
                            'asset/img/${itemMap["이미지"]}',
                            fit: BoxFit.cover, // 이미지가 주어진 공간에 맞게 조정됩니다.
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(itemMap["상품명"]),
                        SizedBox(height: 5),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

Future<String> getItems() async {
  return await rootBundle.loadString('asset/json/new_item.json');
}