import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:upcloth/constant/color.dart';

import '../../enum/home/home_category_enum.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback showTodayRecommend;
  final VoidCallback showNewItem;

  const HomeScreen(
      {required this.showNewItem, required this.showTodayRecommend, super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();
  final PageController _pageController = PageController();
  List<String> categories = Categories.values
      .map((category) => category.toString().split('.').last)
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.recycling,
                            color: GREEN_COLOR,
                            size: 36,
                          ),
                          Text(
                            'UPCloth',
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          print('알람 클릭!!');
                        },
                        child: Material(
                          elevation: 5.0,
                          shape: CircleBorder(),
                          child: Container(
                            width: 48.0,
                            height: 48.0,
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            child: const Center(
                              child: Image(
                                image: AssetImage('asset/img/bell.png'),
                                width: 24,
                                height: 24,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    height: 48,
                    child: TextField(
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        controller: _searchController,
                        decoration: const InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFF3F3F3),
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                                borderSide: BorderSide(color: Colors.transparent)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                                borderSide: BorderSide(
                                    color: Colors.transparent) // 활성 상태일 때의 테두리 색상
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.black,
                            ))),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  _BannerWithDots(controller: _pageController),
                  SizedBox(height: 36),
                  _Categories(category: categories),
                  _TodayItems(showTodayRecommend: widget.showTodayRecommend),
                  const SizedBox(
                    height: 12,
                  ),
                  _TodaysItemList(),
                  SizedBox(
                    height: 24,
                  ),
                  _NewItems(showNewItem: widget.showNewItem),
                  SizedBox(
                    height: 12,
                  ),
                  _NewItemsList(),
                ],
              ),
            ),
          ),
        ));
  }
}

// Banner
class _BannerWithDots extends StatefulWidget {
  final PageController controller;

  const _BannerWithDots({required this.controller, Key? key}) : super(key: key);

  @override
  State<_BannerWithDots> createState() => _BannerWithDotsState();
}

class _BannerWithDotsState extends State<_BannerWithDots> {
  int _currentBannerIndex = 0;

  @override
  Widget build(BuildContext context) {
    final banners = <Widget>[
      Container(color: Color(0xFFF3F3F3)),
      Container(color: Colors.blue),
      Container(color: Colors.green),
      Container(color: Colors.yellow),
    ];
    return Column(
      children: [
        SizedBox(
          height: 128,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: PageView(
              controller: widget.controller,
              children: banners,
              onPageChanged: (index) {
                setState(() {
                  _currentBannerIndex = index;
                });
              },
            ),
          ),
        ),
        DotsIndicator(
          dotsCount: banners.length,
          position: _currentBannerIndex,
          decorator: DotsDecorator(
            size: const Size.square(12.0),
            activeSize: const Size.square(12.0),
            activeColor: GREEN_COLOR,
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100.0)),
            spacing: const EdgeInsets.only(left: 4.0, right: 4.0, top: 8.0),
          ),
        )
      ],
    );
  }
}

class _Categories extends StatelessWidget {
  final List<String> category;

  const _Categories({required this.category, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: category
                  .map((e) => Row(
                children: [
                  TextButton(
                    onPressed: () {
                      print('$e category Clicked!!');
                    },
                    child: Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                          color: Color(0xFFD9D9D9),
                          borderRadius: BorderRadius.circular(100)
                      ),
                      child: Center(
                        child: Text(
                          e,
                          style: TextStyle(
                              color: Colors.black, fontSize: 8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  )
                ],
              ))
                  .toList()),
        ));
  }
}

class _TodayItems extends StatefulWidget {
  final VoidCallback showTodayRecommend;

  const _TodayItems({required this.showTodayRecommend, super.key});

  @override
  State<_TodayItems> createState() => _TodayItemsState();
}

class _TodayItemsState extends State<_TodayItems> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.showTodayRecommend,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.only(top: 24),
        alignment: Alignment.centerLeft,
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "오늘의 추천 아이템",
            style: TextStyle(
                fontFamily: 'Inter',
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          Icon(
            Icons.chevron_right,
            color: Colors.black,
            size: 24,
          ),
        ],
      ),
    );
  }
}

class _TodaysItemList extends StatefulWidget {
  const _TodaysItemList({super.key});

  @override
  State<_TodaysItemList> createState() => _TodaysItemListState();
}

class _TodaysItemListState extends State<_TodaysItemList> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          onTap: () {
            print("Container tapped!"); // 여기에 원하는 동작을 추가합니다.
          },
          child: Container(
            child: Column(
              children: [
                Container(
                  width: 72,
                  height: 72,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset('asset/img/example_outer1.jpeg',
                        fit: BoxFit.cover),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: Text(
                    "상품명",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
        InkWell(
          child: Container(
            child: Column(
              children: [
                Container(
                  width: 72,
                  height: 72,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset('asset/img/example_outer1.jpeg',
                        fit: BoxFit.cover),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: Text(
                    "상품명",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
        InkWell(
          child: Container(
            child: Column(
              children: [
                Container(
                  width: 72,
                  height: 72,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset('asset/img/example_outer1.jpeg',
                        fit: BoxFit.cover),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: Text(
                    "상품명",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
        InkWell(
          child: Container(
            child: Column(
              children: [
                Container(
                  width: 72,
                  height: 72,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset('asset/img/example_outer1.jpeg',
                        fit: BoxFit.cover),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: Text(
                    "상품명",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _NewItems extends StatefulWidget {
  final VoidCallback showNewItem;

  const _NewItems({required this.showNewItem, super.key});

  @override
  State<_NewItems> createState() => _NewItemsState();
}

class _NewItemsState extends State<_NewItems> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.showNewItem,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.centerLeft,
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "신규 아이템",
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Icon(Icons.chevron_right, color: Colors.black, size: 24),
        ],
      ),
    );
  }
}

class _NewItemsList extends StatefulWidget {
  const _NewItemsList({super.key});

  @override
  State<_NewItemsList> createState() => _NewItemsListState();
}

class _NewItemsListState extends State<_NewItemsList> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          child: Container(
            child: Column(
              children: [
                Container(
                  width: 72,
                  height: 72,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset('asset/img/example_outer1.jpeg',
                        fit: BoxFit.cover),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: Text(
                    "상품명",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
        InkWell(
          child: Container(
            child: Column(
              children: [
                Container(
                  width: 72,
                  height: 72,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset('asset/img/example_outer1.jpeg',
                        fit: BoxFit.cover),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: Text(
                    "상품명",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
        InkWell(
          child: Container(
            child: Column(
              children: [
                Container(
                  width: 72,
                  height: 72,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset('asset/img/example_outer1.jpeg',
                        fit: BoxFit.cover),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: Text(
                    "상품명",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
        InkWell(
          child: Container(
            child: Column(
              children: [
                Container(
                  width: 72,
                  height: 72,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset('asset/img/example_outer1.jpeg',
                        fit: BoxFit.cover),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: Text(
                    "상품명",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}