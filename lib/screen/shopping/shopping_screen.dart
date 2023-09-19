import 'package:flutter/material.dart';
import 'package:upcloth/enum/shopping/sub_category_enum.dart';

import '../../constant/color.dart';
import '../../enum/shopping/top_category_enum.dart';

class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen({super.key});

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  @override
  Widget build(BuildContext context) {
    final _searchController = TextEditingController();
    List<TopCategory> topCategories = TopCategory.values;
    List<SubCategory> subCategories = SubCategory.values;
    int _selectedIndex = 0;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              _Headers(
                searchController: _searchController,
              ),
              const SizedBox(
                height: 24,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: topCategories
                      .map((category) => TextButton(
                          onPressed: () {
                            print(TopCategoryNames[category]);
                          },
                          child: Text(
                            TopCategoryNames[category] ?? '',
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16),
                          )))
                      .toList(),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              SingleChildScrollView(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ...subCategories
                        .asMap()
                        .entries
                        .map((category) => Padding(
                              padding: EdgeInsets.only(
                                  left: category.key == 0.0 ? 0.0 : 8.0),
                              child: SizedBox(
                                width: 74.0,
                                height: 32.0,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                      primary: Colors.white,
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
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
                  ],
                ),
              )
            ],
          ),
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
    return Padding(
        padding:
            const EdgeInsets.only(left: 20.0, right: 20.0, top: 32, bottom: 24),
        child: Row(
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
                  style:
                      TextStyle(color: GREY_COLOR, fontWeight: FontWeight.bold),
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
        ));
  }
}
