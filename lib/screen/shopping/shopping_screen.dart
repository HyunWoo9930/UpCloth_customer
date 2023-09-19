import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:upcloth/enum/shopping/sub_category_enum.dart';

import '../../constant/color.dart';
import '../../enum/shopping/top_category_enum.dart';

//TODO subCategory 왼쪽 정렬
//TODO 버튼 눌렀을때, 아래 초록색 선 뜨게.

class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen({super.key});

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final _searchController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 32,
                    ),
                    _Headers(
                      searchController: _searchController,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    _TopCategory(),
                    const SizedBox(
                      height: 12,
                    ),
                    _SubCategory(),
                    const SizedBox(
                      height: 12,
                    ),
                    _Items(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Headers extends StatefulWidget {
  final TextEditingController searchController;

  const _Headers({required this.searchController, super.key});

  @override
  State<_Headers> createState() => _HeadersState();
}

class _HeadersState extends State<_Headers> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.keyboard_arrow_left,
              size: 36,
            )),
        SizedBox(
          width: 20,
        ),
        SizedBox(
          width: 297,
          height: 48,
          child: TextField(
              style: TextStyle(color: GREY_COLOR, fontWeight: FontWeight.bold),
              controller: widget.searchController,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Color(0xFFF3F3F3),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(100.0)),
                    borderSide: BorderSide(color: Colors.transparent)),
              )),
        )
      ],
    );
  }
}

class _TopCategory extends StatefulWidget {
  const _TopCategory({super.key});

  @override
  State<_TopCategory> createState() => _TopCategoryState();
}

class _TopCategoryState extends State<_TopCategory> {
  List<TopCategory> topCategories = TopCategory.values;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: topCategories
                .asMap()
                .entries
                .map((entry) => TextButton(
                    onPressed: () {},
                    child: Text(
                      TopCategoryNames[entry.value] ?? '',
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    )))
                .toList(),
          ),
        ),
        Container(
          height: 1,
          color: GREY_COLOR,
        )
      ],
    );
  }
}

class _SubCategory extends StatefulWidget {
  const _SubCategory({super.key});

  @override
  State<_SubCategory> createState() => _SubCategoryState();
}

class _SubCategoryState extends State<_SubCategory> {
  List<SubCategory> subCategories = SubCategory.values;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: subCategories
            .asMap()
            .entries
            .map((category) => Padding(
                  padding:
                      EdgeInsets.only(left: category.key == 0.0 ? 0.0 : 8.0),
                  child: SizedBox(
                    width: 74.0,
                    height: 32.0,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide.none),
                          elevation: 8,
                          shadowColor: Colors.black,
                          padding: EdgeInsets.all(1.0)),
                      onPressed: () {
                        print('$category clicked!!');
                      },
                      child: Text(
                        SubCategoryName[category.value] ?? '',
                        style: const TextStyle(
                            fontFamily: 'Inter',
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 12),
                      ),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class _Items extends StatefulWidget {
  const _Items({super.key});

  @override
  State<_Items> createState() => _ItemsState();
}

class _ItemsState extends State<_Items> {
  Future<List<dynamic>> loadRecommendItems() async {
    final recommendItemsData =
        await rootBundle.loadString('asset/json/all_item.json');
    return jsonDecode(recommendItemsData);
  }

  late Future<List<dynamic>> recommendItemsListFuture;

  @override
  void initState() {
    super.initState();
    recommendItemsListFuture = loadRecommendItems();
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
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                            print('${itemMap['상품명']} clicked!!!');
                          },
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Image.asset(
                                  'asset/img/${itemMap['이미지']}',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                height: 50.0,
                                bottom: 0,  // 위에서 10.0의 거리를 둡니다. 필요한 경우 조절하세요.
                                right: 0,  // 왼쪽에서 10.0의 거리를 둡니다. 필요한 경우 조절하세요.
                                left: 0,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                  color: Colors.black.withOpacity(0.5),  // 반투명한 배경색을 추가
                                  child: Text(
                                    itemMap['가격'],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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
