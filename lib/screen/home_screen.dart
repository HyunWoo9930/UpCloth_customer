import 'package:flutter/material.dart';
import 'package:upcloth/screen/new_item_screen.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback showTodayRecommend;
  final VoidCallback showNewItem;

  HomeScreen(
      {required this.showTodayRecommend, required this.showNewItem, super.key});

  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            _Header(
              onPageChanged: _onPageChanged,
              pageController: _pageController,
            ),
            _Body(),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text('오늘의 추천 아이템',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.square_rounded),
                            color: Colors.grey,
                            iconSize: 75,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.square_rounded),
                            color: Colors.grey,
                            iconSize: 75,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.square_rounded),
                            color: Colors.grey,
                            iconSize: 75,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.square_rounded),
                            color: Colors.grey,
                            iconSize: 75,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: ElevatedButton(
                            onPressed: showTodayRecommend,
                            style: ElevatedButton.styleFrom(
                              primary: Colors.grey,
                            ),
                            child: const Text('더보기')),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        '신규 아이템',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.square_rounded),
                            color: Colors.grey,
                            iconSize: 75,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.square_rounded),
                            color: Colors.grey,
                            iconSize: 75,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.square_rounded),
                            color: Colors.grey,
                            iconSize: 75,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.square_rounded),
                            color: Colors.grey,
                            iconSize: 75,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: ElevatedButton(
                            onPressed: showNewItem,
                            style: ElevatedButton.styleFrom(
                              primary: Colors.grey,
                            ),
                            child: const Text('더보기')),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onPageChanged(int pageIndex) {}
}

///  Banner build 하는 widget
class _buildBanner extends StatelessWidget {
  final String text;

  const _buildBanner({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0), // 원하는 둥근 정도를 설정합니다.
        color: Colors.grey,
      ),
      child: Center(child: Text(text)),
    );
  }
}

/// Banner Header
class _Header extends StatelessWidget {
  final ValueChanged<int> onPageChanged;
  final PageController pageController;

  const _Header(
      {required this.onPageChanged, required this.pageController, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: const [
          _buildBanner(text: 'Banner 1'),
          _buildBanner(text: 'Banner 2'),
          _buildBanner(text: 'Banner 3')
        ],
      ),
    );
  }
}

/// 배너 아래 카테고리 영역
class _Body extends StatelessWidget {
  const _Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.circle),
                iconSize: 60,
                color: Colors.red,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.circle),
                iconSize: 60,
                color: Colors.yellow,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.circle),
                iconSize: 60,
                color: Colors.orange,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.circle),
                iconSize: 60,
                color: Colors.green,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.circle),
                iconSize: 60,
                color: Colors.blue,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.circle),
                iconSize: 60,
                color: Colors.purple,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
