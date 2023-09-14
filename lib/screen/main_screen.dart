import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  int _pageIndex = 0;

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
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: 'search'),
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'myPage'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart), label: 'cart'),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Banner(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
              ),
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
                              iconSize: 75,
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.square_rounded),
                              iconSize: 75,
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.square_rounded),
                              iconSize: 75,
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.square_rounded),
                              iconSize: 75,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: ElevatedButton(
                              onPressed: () {},
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
                              iconSize: 75,
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.square_rounded),
                              iconSize: 75,
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.square_rounded),
                              iconSize: 75,
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.square_rounded),
                              iconSize: 75,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: ElevatedButton(
                              onPressed: () {},
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
        ));
  }

  Widget buildBanner(String text, int index) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0), // 원하는 둥근 정도를 설정합니다.
        color: Colors.grey,
      ),
      child: Center(child: Text(text)),
    );
  }

  Widget Banner() {
    return SizedBox(
      height: 100,
      child: PageView(
        controller: _pageController,
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
        },
        children: [
          buildBanner('Banner 1', 0),
          buildBanner('Banner 2', 1),
          buildBanner('Banner 3', 2),
        ],
      ),
    );
  }
}

