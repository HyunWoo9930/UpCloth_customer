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
  int _currentBannerIndex = 0;

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
              _alarm(),
              const SizedBox(
                height: 12,
              ),
              _search(),
              const SizedBox(
                height: 24,
              ),
              _bannerWithDotsState(_pageController),
              const SizedBox(
                height: 36,
              ),
              _categories(categories),
              _todayItems(),
              const SizedBox(
                height: 12,
              ),
              _todayItemList(),
              const SizedBox(
                height: 24,
              ),
              _newItems(),
              const SizedBox(
                height: 12,
              ),
              _newItemList(),
            ],
          ),
        ),
      ),
    ));
  }

  Widget _alarm() {
    return Row(
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
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        InkWell(
          onTap: () {
            print('알람 클릭!!');
          },
          child: Material(
            elevation: 5.0,
            shape: const CircleBorder(),
            child: Container(
              width: 48.0,
              height: 48.0,
              decoration: const BoxDecoration(shape: BoxShape.circle),
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
    );
  }

  Widget _search() {
    return SizedBox(
      height: 48,
      child: TextField(
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          controller: _searchController,
          decoration: const InputDecoration(
              filled: true,
              fillColor: Color(0xFFF3F3F3),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.transparent)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide:
                      BorderSide(color: Colors.transparent) // 활성 상태일 때의 테두리 색상
                  ),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.black,
              ))),
    );
  }

  Widget _bannerWithDotsState(PageController controller) {
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
              controller: controller,
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

  Widget _categories(List<String> category) {
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
                              color: const Color(0xFFD9D9D9),
                              borderRadius: BorderRadius.circular(100)),
                          child: Center(
                            child: Text(
                              e,
                              style:
                                  const TextStyle(color: Colors.black, fontSize: 8),
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

  Widget _todayItems() {
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

  Widget _todayItemList() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _item('asset/img/example_outer1.jpeg'),
        _item('asset/img/example_outer1.jpeg'),
        _item('asset/img/example_outer1.jpeg'),
        _item('asset/img/example_outer1.jpeg'),
      ],
    );
  }

  Widget _newItems() {
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

  Widget _newItemList() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _item('asset/img/example_outer1.jpeg'),
        _item('asset/img/example_outer1.jpeg'),
        _item('asset/img/example_outer1.jpeg'),
        _item('asset/img/example_outer1.jpeg'),
      ],
    );
  }

  InkWell _item(String path) {
    return InkWell(
      child: Container(
        child: Column(
          children: [
            Container(
              width: 72,
              height: 72,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset(path, fit: BoxFit.cover),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 2),
              child: Text(
                "상품명",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
