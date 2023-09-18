import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:upcloth/constant/color.dart';

import '../../enum/category_enum.dart';

class HomeScreen2 extends StatefulWidget {
  final VoidCallback showTodayRecommend;
  final VoidCallback showNewItem;

  const HomeScreen2(
      {required this.showNewItem, required this.showTodayRecommend, super.key});

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
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
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.recycling,
                      color: GREEN_COLOR,
                      size: 40,
                    ),
                    Text(
                      'UPCloth',
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
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
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: Icon(
                        Icons.add_alert,
                        color: Colors.black,
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 40,
              child: TextField(
                  style:
                      TextStyle(color: GREY_COLOR, fontWeight: FontWeight.bold),
                  controller: _searchController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFF3F3F3),
                      enabledBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(100.0)),
                          borderSide: BorderSide(color: Colors.transparent)),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.black,
                      ))),
            ),
            SizedBox(
              height: 15,
            ),
            _BannerWithDots(controller: _pageController),
            _Categories(category: categories),
            _TodayItems(showTodayRecommend: widget.showTodayRecommend),
            SizedBox(
              height: 10,
            ),
            _TodaysItemList(),
            SizedBox(
              height: 10,
            ),
            _NewItems(showNewItem: widget.showNewItem),
            SizedBox(
              height: 10,
            ),
            _NewItemsList(),
          ],
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
      Container(color: GREY_COLOR),
      Container(color: Colors.blue),
      Container(color: Colors.green),
      Container(color: Colors.yellow),
    ];
    return Column(
      children: [
        SizedBox(
          height: 150,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
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
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeColor: GREEN_COLOR,
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
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
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Container(
            child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: category
                  .map((e) => TextButton(
                        onPressed: () {
                          print('$e category Clicked!!');
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            const Icon(
                              Icons.circle,
                              size: 70,
                              color: GREY_COLOR,
                            ),
                            Text(
                              e,
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ))
                  .toList()),
        )));
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "오늘의 추천 아이템",
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Icon(
            Icons.chevron_right,
            color: Colors.black,
            size: 30,
          ),
        ],
      ),
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.centerLeft,
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
            width: 70, // 원하는 너비를 지정합니다.
            height: 120, // 원하는 높이를 지정합니다.
            child: Column(
              children: [
                Expanded(
                  // 이미지를 컨테이너의 상단 부분에 표시
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset('asset/img/example_outer1.jpeg',
                        fit: BoxFit.cover), // 이미지 경로를 자신의 앱의 이미지 경로로 변경해야 합니다.
                  ),
                ),
                Padding(
                  // 텍스트를 컨테이너의 하단 부분에 표시
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "상품명",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.transparent, // 원하는 배경색을 지정합니다.
              borderRadius: BorderRadius.circular(15), // 모서리를 둥글게
            ),
          ),
        ),
        InkWell(
          onTap: () {
            print("Container tapped!"); // 여기에 원하는 동작을 추가합니다.
          },
          child: Container(
            width: 70, // 원하는 너비를 지정합니다.
            height: 120, // 원하는 높이를 지정합니다.
            child: Column(
              children: [
                Expanded(
                  // 이미지를 컨테이너의 상단 부분에 표시
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset('asset/img/example_outer1.jpeg',
                        fit: BoxFit.cover), // 이미지 경로를 자신의 앱의 이미지 경로로 변경해야 합니다.
                  ),
                ),
                Padding(
                  // 텍스트를 컨테이너의 하단 부분에 표시
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "상품명",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.transparent, // 원하는 배경색을 지정합니다.
              borderRadius: BorderRadius.circular(15), // 모서리를 둥글게
            ),
          ),
        ),
        InkWell(
          onTap: () {
            print("Container tapped!"); // 여기에 원하는 동작을 추가합니다.
          },
          child: Container(
            width: 70, // 원하는 너비를 지정합니다.
            height: 120, // 원하는 높이를 지정합니다.
            child: Column(
              children: [
                Expanded(
                  // 이미지를 컨테이너의 상단 부분에 표시
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset('asset/img/example_outer1.jpeg',
                        fit: BoxFit.cover), // 이미지 경로를 자신의 앱의 이미지 경로로 변경해야 합니다.
                  ),
                ),
                Padding(
                  // 텍스트를 컨테이너의 하단 부분에 표시
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "상품명",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.transparent, // 원하는 배경색을 지정합니다.
              borderRadius: BorderRadius.circular(15), // 모서리를 둥글게
            ),
          ),
        ),
        InkWell(
          onTap: () {
            print("Container tapped!"); // 여기에 원하는 동작을 추가합니다.
          },
          child: Container(
            width: 70, // 원하는 너비를 지정합니다.
            height: 120, // 원하는 높이를 지정합니다.
            child: Column(
              children: [
                Expanded(
                  // 이미지를 컨테이너의 상단 부분에 표시
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset('asset/img/example_outer1.jpeg',
                        fit: BoxFit.cover), // 이미지 경로를 자신의 앱의 이미지 경로로 변경해야 합니다.
                  ),
                ),
                Padding(
                  // 텍스트를 컨테이너의 하단 부분에 표시
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "상품명",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.transparent, // 원하는 배경색을 지정합니다.
              borderRadius: BorderRadius.circular(15), // 모서리를 둥글게
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "신규 아이템",
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Icon(
            Icons.chevron_right,
            color: Colors.black,
            size: 30,
          ),
        ],
      ),
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.centerLeft,
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
          onTap: () {
            print("Container tapped!"); // 여기에 원하는 동작을 추가합니다.
          },
          child: Container(
            width: 70, // 원하는 너비를 지정합니다.
            height: 120, // 원하는 높이를 지정합니다.
            child: Column(
              children: [
                Expanded(
                  // 이미지를 컨테이너의 상단 부분에 표시
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset('asset/img/example_outer1.jpeg',
                        fit: BoxFit.cover), // 이미지 경로를 자신의 앱의 이미지 경로로 변경해야 합니다.
                  ),
                ),
                Padding(
                  // 텍스트를 컨테이너의 하단 부분에 표시
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "상품명",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.transparent, // 원하는 배경색을 지정합니다.
              borderRadius: BorderRadius.circular(15), // 모서리를 둥글게
            ),
          ),
        ),
        InkWell(
          onTap: () {
            print("Container tapped!"); // 여기에 원하는 동작을 추가합니다.
          },
          child: Container(
            width: 70, // 원하는 너비를 지정합니다.
            height: 120, // 원하는 높이를 지정합니다.
            child: Column(
              children: [
                Expanded(
                  // 이미지를 컨테이너의 상단 부분에 표시
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset('asset/img/example_outer1.jpeg',
                        fit: BoxFit.cover), // 이미지 경로를 자신의 앱의 이미지 경로로 변경해야 합니다.
                  ),
                ),
                Padding(
                  // 텍스트를 컨테이너의 하단 부분에 표시
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "상품명",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.transparent, // 원하는 배경색을 지정합니다.
              borderRadius: BorderRadius.circular(15), // 모서리를 둥글게
            ),
          ),
        ),
        InkWell(
          onTap: () {
            print("Container tapped!"); // 여기에 원하는 동작을 추가합니다.
          },
          child: Container(
            width: 70, // 원하는 너비를 지정합니다.
            height: 120, // 원하는 높이를 지정합니다.
            child: Column(
              children: [
                Expanded(
                  // 이미지를 컨테이너의 상단 부분에 표시
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset('asset/img/example_outer1.jpeg',
                        fit: BoxFit.cover), // 이미지 경로를 자신의 앱의 이미지 경로로 변경해야 합니다.
                  ),
                ),
                Padding(
                  // 텍스트를 컨테이너의 하단 부분에 표시
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "상품명",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.transparent, // 원하는 배경색을 지정합니다.
              borderRadius: BorderRadius.circular(15), // 모서리를 둥글게
            ),
          ),
        ),
        InkWell(
          onTap: () {
            print("Container tapped!"); // 여기에 원하는 동작을 추가합니다.
          },
          child: Container(
            width: 70, // 원하는 너비를 지정합니다.
            height: 120, // 원하는 높이를 지정합니다.
            child: Column(
              children: [
                Expanded(
                  // 이미지를 컨테이너의 상단 부분에 표시
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset('asset/img/example_outer1.jpeg',
                        fit: BoxFit.cover), // 이미지 경로를 자신의 앱의 이미지 경로로 변경해야 합니다.
                  ),
                ),
                Padding(
                  // 텍스트를 컨테이너의 하단 부분에 표시
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "상품명",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.transparent, // 원하는 배경색을 지정합니다.
              borderRadius: BorderRadius.circular(15), // 모서리를 둥글게
            ),
          ),
        ),
      ],
    );
  }
}
