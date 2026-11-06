import 'package:flutter/material.dart' hide SearchController;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:minbus_weather_app/Components/MyTextfieldcomponent.dart';
import 'package:minbus_weather_app/Controller/ExploreController.dart';
import 'package:minbus_weather_app/Controller/SearchController.dart';
import 'package:minbus_weather_app/Utils/Appicons.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  late final Explorecontroller exploreController;
  late final TextEditingController _searchController;
  late final SearchController searchController;

  @override
  void initState() {
    super.initState();
    exploreController = Get.put(Explorecontroller());
    searchController = Get.put(SearchController());
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F6FF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good evening',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF7183A7),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Demo Student',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF102344),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 44,
                    height: 44,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Color(0xFF326BFF),
                      shape: BoxShape.circle,
                    ),
                    child: const Text(
                      'DS',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Search field triggers ONLY when search icon or keyboard action is submitted
              Mytextfieldcomponent(
                hintText: "Search cities",
                controller: _searchController,
                prefixIcon: InkWell(
                  onTap: () {
                    setState(() {}); // Updates UI to acknowledge non-empty query string
                    searchController.getSearch(_searchController.text);
                  },
                  child: const Icon(Icons.search),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear, size: 20),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {});
                    searchController.getSearch("");
                  },
                ),
              ),

              const SizedBox(height: 16),

              // Region filters wrapped in Obx
              SizedBox(
                height: 45,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Obx(
                        () => Row(
                      children: exploreController.regions.map((region) {
                        final bool selected =
                            exploreController.selectedRegion.value == region;

                        return GestureDetector(
                          onTap: () => exploreController.selectRegion(region),
                          child: Container(
                            margin: const EdgeInsets.only(right: 8),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 11,
                            ),
                            decoration: BoxDecoration(
                              color: selected
                                  ? const Color(0xFF326BFF)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(
                                color: selected
                                    ? const Color(0xFF326BFF)
                                    : const Color(0xFFDCE5F8),
                              ),
                            ),
                            child: Text(
                              region,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: selected
                                    ? Colors.white
                                    : const Color(0xFF61769A),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // Dynamic results count header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Cities',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF102344),
                    ),
                  ),
                  Obx(() {
                    final bool isSearching = _searchController.text.trim().isNotEmpty;
                    final int count = isSearching
                        ? searchController.listofsearchcities.length
                        : exploreController.listofcities.length;

                    return Text(
                      '$count results',
                      style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                    );
                  }),
                ],
              ),

              const SizedBox(height: 14),

              // Main List View / Loader wrapped in Obx
              Expanded(
                child: Obx(() {
                  final bool isSearching = _searchController.text.trim().isNotEmpty;

                  if (isSearching && searchController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!isSearching &&
                      exploreController.isLoading.value &&
                      exploreController.listofcities.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final dataList = isSearching
                      ? searchController.listofsearchcities
                      : exploreController.listofcities;

                  if (dataList.isEmpty) {
                    return const Center(
                      child: Text(
                        "No cities found",
                        style: TextStyle(color: Color(0xFF7183A7), fontSize: 14),
                      ),
                    );
                  }

                  final meta = exploreController.responseModel.value.meta;
                  int pagenumber = meta?.page ?? 1;
                  int totalpages = meta?.totalPages ?? 1;
                  int nextPages = pagenumber + 1;
                  bool showLoadMore = !isSearching && (pagenumber < totalpages);

                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: dataList.length + (showLoadMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (showLoadMore && index == dataList.length) {
                        return InkWell(
                          onTap: () {
                            exploreController.getCities(nextPages, 4);
                          },
                          child: Container(
                            height: 48,
                            margin: const EdgeInsets.only(top: 2, bottom: 16),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE2EBFF),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Load more · page $pagenumber of $totalpages',
                              style: const TextStyle(
                                color: Color(0xFF326BFF),
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      }

                      final city = dataList[index];

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: _buildCityCard(
                          city: city.name ?? "",
                          country: city.country ?? "",
                          region: city.region ?? "",
                          temperature: city.weather?.temperatureC?.toString() ?? "0",
                          icon: city.weather?.condition?.icon ?? "",
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // City card builder method
  Widget _buildCityCard({
    required String city,
    required String country,
    required String region,
    required String temperature,
    required String icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: icon == 'rain'
                  ? const Color(0xFFE5EDFF)
                  : const Color(0xFFFFF2CC),
              borderRadius: BorderRadius.circular(14),
            ),
            child: icon == 'rain'
                ? SvgPicture.asset(Appicons.rain, width: 30, height: 30)
                : Icon(
              icon == 'sun'
                  ? Icons.wb_sunny_outlined
                  : Icons.cloud_outlined,
              size: 30,
              color: const Color(0xFFFFB800),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  city,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF102344),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$country · $region',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF7183A7),
                  ),
                ),
              ],
            ),
          ),
          Text(
            "$temperature°",
            style: const TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: Color(0xFF102344),
            ),
          ),
        ],
      ),
    );
  }
}