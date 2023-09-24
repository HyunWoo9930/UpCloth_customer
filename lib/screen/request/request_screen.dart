import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:upcloth/constant/color.dart';
import 'package:upcloth/screen/login_screen_customer.dart';
import 'package:upcloth/screen/request/store_list_screen.dart';
import '../util/util.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  @override
  Widget build(BuildContext context) {
    var statusBarHeight = MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: statusBarHeight),
        child: const Column(
          children: [
            SizedBox(
              height: 10,
            ),
            CustomAppBar(text: '상품의뢰'),
            SizedBox(
              height: 24,
            ),
            _Region()
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        child: SizedBox(
          height: 32.0,
          width: double.infinity,
          child: TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                Map<String, dynamic> myMap = {
                  "시/도" : {
                    "이름": "서울특별시",
                    "시/군/구": {
                      "이름": "구로구",
                      "읍/면/동": {
                        "이름": "구로동"
                      }
                    }
                  }
                };
                return StoreListScreen(data: myMap);
              }));
            },
            style: TextButton.styleFrom(
                backgroundColor: GREEN_COLOR,
                primary: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0))),
            child: const Text(
              '검색',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
            ),
          ),
        ),
      ),
    );
  }
}

class RegionData {
  final List<Region> regions;

  RegionData({required this.regions});

  factory RegionData.fromJson(Map<String, dynamic> json) {
    final List<dynamic> regionList = json['시/도'];
    final regions =
        regionList.map((regionJson) => Region.fromJson(regionJson)).toList();
    return RegionData(regions: regions);
  }
}

class Region {
  final String name;
  final List<City> cities;

  Region({required this.name, required this.cities});

  factory Region.fromJson(Map<String, dynamic> json) {
    final String name = json['이름'];
    final List<dynamic> cityList = json['시/군/구'];
    final cities = cityList.map((cityJson) => City.fromJson(cityJson)).toList();
    return Region(name: name, cities: cities);
  }
}

class City {
  final String name;
  final List<String> neighborhoods;

  City({required this.name, required this.neighborhoods});

  factory City.fromJson(Map<String, dynamic> json) {
    final String name = json['이름'];
    final List<dynamic> neighborhoodList = json['읍/면/동'];
    final neighborhoods =
        neighborhoodList.map((neighborhood) => neighborhood as String).toList();
    return City(name: name, neighborhoods: neighborhoods);
  }
}

class RegionListWidget extends StatefulWidget {
  final RegionData regionData;

  RegionListWidget({required this.regionData});

  @override
  _RegionListWidgetState createState() => _RegionListWidgetState();
}

class _RegionListWidgetState extends State<RegionListWidget> {
  int? selectedRegionIndex;
  int? selectedCityIndex;
  int? selectedNeighborhoodIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("시/도 선택",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            )),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(top: 12.0, bottom: 36),
          child: Row(children: [
            for (var regionIndex = 0;
                regionIndex < widget.regionData.regions.length;
                regionIndex++)
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Container(
                  // width: 74,
                  height: 32,
                  decoration: ShapeDecoration(
                    color: selectedRegionIndex == regionIndex
                        ? Colors.green
                        : Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(1, 1),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        selectedRegionIndex = regionIndex;
                        selectedCityIndex = null; // 선택한 시/도 초기화
                        selectedNeighborhoodIndex = null; // 선택한 시/군/구 초기화
                      });
                    },
                    child: Text(
                      widget.regionData.regions[regionIndex].name,
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Inter',
                          color: selectedRegionIndex == regionIndex
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
          ]),
        ),
        if (selectedRegionIndex != null) ...[
          const Text("시/군/구 선택",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              )),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(top: 12, bottom: 36),
            child: Row(children: [
              for (var cityIndex = 0;
                  cityIndex <
                      widget.regionData.regions[selectedRegionIndex!].cities
                          .length;
                  cityIndex++)
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Container(
                    // width: 74,
                    height: 32,
                    decoration: ShapeDecoration(
                      color: selectedCityIndex == cityIndex
                          ? Colors.green
                          : Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 4,
                          offset: Offset(1, 1),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: TextButton(
                      // style: TextButton.styleFrom(
                      //     primary: Colors.white,
                      //     backgroundColor: selectedCityIndex == cityIndex
                      //         ? Colors.green
                      //         : Colors.white,
                      //     shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(12.0),
                      //         side: BorderSide.none),
                      //     elevation: 8,
                      //     shadowColor: Colors.black),
                      onPressed: () {
                        setState(() {
                          selectedCityIndex = cityIndex;
                          selectedNeighborhoodIndex = null; // 선택한 시/군/구 초기화
                        });
                      },
                      child: Text(
                        widget.regionData.regions[selectedRegionIndex!]
                            .cities[cityIndex].name,
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Inter',
                          color: selectedCityIndex == cityIndex
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
            ]),
          ),
        ],
        if (selectedCityIndex != null) ...[
          const Text(
            "읍/면/동 선택",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(top: 12, bottom: 36),
            child: Row(children: [
              for (var neighborhoodIndex = 0;
                  neighborhoodIndex <
                      widget.regionData.regions[selectedRegionIndex!]
                          .cities[selectedCityIndex!].neighborhoods.length;
                  neighborhoodIndex++)
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Container(
                    height: 32,
                    decoration: ShapeDecoration(
                      color: selectedNeighborhoodIndex == neighborhoodIndex
                          ? Colors.green
                          : Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 4,
                          offset: Offset(1, 1),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: TextButton(
                      onPressed: () {
                        // 선택한 읍/면/동에 대한 동작 수행
                        setState(() {
                          selectedNeighborhoodIndex = neighborhoodIndex;
                        });
                      },
                      child: Text(
                        widget
                            .regionData
                            .regions[selectedRegionIndex!]
                            .cities[selectedCityIndex!]
                            .neighborhoods[neighborhoodIndex],
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Inter',
                            color:
                                selectedNeighborhoodIndex == neighborhoodIndex
                                    ? Colors.white
                                    : Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
            ]),
          ),
        ],
      ],
    );
  }
}

class _Region extends StatefulWidget {
  const _Region({super.key});

  @override
  State<_Region> createState() => _RegionState();
}

class _RegionState extends State<_Region> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: rootBundle.loadString('asset/json/region.json'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final jsonData = jsonDecode(snapshot.data!);
            final regionData = RegionData.fromJson(jsonData);
            return RegionListWidget(regionData: regionData);
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
