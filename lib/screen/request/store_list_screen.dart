import 'package:flutter/material.dart';
import 'package:upcloth/screen/request/request_store_detail_screen.dart';
import 'package:upcloth/screen/util/util.dart';

class StoreListScreen extends StatefulWidget {
  final Map<String, dynamic> data;

  const StoreListScreen({super.key, required this.data});

  @override
  State<StoreListScreen> createState() => _StoreListScreenState();
}

class _StoreListScreenState extends State<StoreListScreen> {
  @override
  Widget build(BuildContext context) {
    var statusBarHeight = MediaQuery.of(context).viewPadding.top;
    String? regionName = widget.data["시/도"]["이름"];
    String? cityName = widget.data["시/도"]["시/군/구"]["이름"];
    String? neighborhoodName = widget.data["시/도"]["시/군/구"]["읍/면/동"]["이름"];
    String location = "";
    if (regionName != null && regionName.isNotEmpty) {
      if (cityName != null && cityName.isNotEmpty) {
        if (neighborhoodName != null && neighborhoodName.isNotEmpty) {
          location = "$regionName > $cityName > $neighborhoodName";
        } else {
          location = "$regionName > $cityName";
        }
      } else {
        location = regionName;
      }
    }
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: statusBarHeight),
        child: Column(children: [
          const CustomAppBar(text: '상품의뢰'),
          const SizedBox(
            height: 24,
          ),
          Row(
            children: [
              Container(
                height: 32,
                decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    shadows: const [
                      BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 4,
                          offset: Offset(1, 1),
                          spreadRadius: 0)
                    ]),
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    location,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        fontFamily: 'Inter'),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ScrollConfiguration(
              behavior: NoGlowScrollBehavior(),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    _StoreWidget(
                        Image.asset('asset/img/request_test1.png',
                            fit: BoxFit.cover),
                        '우리동네 수선집',
                        ['리디자인', '수선'],
                        '우리동네 수선집! 오래된 옷도 새것처럼. 정성스런 손봉사로 고객님의 마음까지 포근하게 해드립니다. 신뢰와 품질로 대화해요'),
                    _StoreWidget(
                        Image.asset('asset/img/request_test2.png',
                            fit: BoxFit.cover),
                        '업클로스',
                        ['리디자인', '수선'],
                        '우리동네 수선집! 오래된 옷도 새것처럼. 정성스런 손봉사로 고객님의 마음까지 포근하게 해드립니다. 신뢰와 품질로 대화해요'),
                    Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: Container(
                        width: double.infinity,
                        height: 260,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }

  Widget _StoreWidget(
      Image image, String storeName, List<String> tagList, String storeText) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return const RequestStoreDetailScreen();
        }));
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 24),
        child: Container(
          width: double.infinity,
          height: 260,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: Colors.white),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: image,
              ),
              Container(
                padding: const EdgeInsets.only(left: 8, right: 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      storeName,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 8),
                      child: Row(
                        children: [
                          for (int i = 0; i < tagList.length; i++)
                            Row(
                              children: [
                                StoreTag(text: tagList[i]),
                                if (i < tagList.length - 1)
                                  const SizedBox(width: 12),
                              ],
                            )
                          // StoreTag(text: '수선'),
                          // SizedBox(width: 12),
                          // StoreTag(text: '리디자인')
                        ],
                      ),
                    ),
                    RequestTextFormWidget(text: storeText, isTitle: false)
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
