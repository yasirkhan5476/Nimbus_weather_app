import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:minbus_weather_app/Controller/ExploreController.dart';
import 'package:minbus_weather_app/Utils/Appicons.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final Explorecontroller exploreController = Get.put(Explorecontroller());
  final TextEditingController _searchController = TextEditingController();

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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Header
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
                        SizedBox(height: 2),
                        Text(
                          'Demo Student',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF102344),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
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

              const SizedBox(height: 12),

              // 2. Search bar
              SizedBox(
                height: 46,
                child: TextField(
                  controller: _searchController,
                  style: const TextStyle(fontSize: 14, color: Color(0xFF0F1B2D)),
                  decoration: InputDecoration(
                    hintText: 'Search cities or countries...',
                    hintStyle: const TextStyle(fontSize: 13, color: Color(0xFF8B9BB8)),
                    prefixIcon: const Icon(Icons.search, color: Color(0xFF60769C), size: 18),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(color: Color(0xFFDCE5F8)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(color: Color(0xFFDCE5F8)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(color: Color(0xFF326BFF)),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // 3. Region filters
              SizedBox(
                height: 36,
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
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: selected
                                  ? const Color(0xFF326BFF)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: selected
                                    ? const Color(0xFF326BFF)
                                    : const Color(0xFFDCE5F8),
                              ),
                            ),
                            child: Text(
                              region,
                              style: TextStyle(
                                fontSize: 12,
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

              const SizedBox(height: 14),

              // 4. Cities heading & dynamic results count
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Cities',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF102344),
                    ),
                  ),
                  Obx(
                        () => Text(
                      '${exploreController.responseModel.value.data?.length ?? 0} results',
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // 5. City ListView wrapped safely inside Expanded
              Expanded(
                child: Obx(() {
                  if (exploreController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final dataList = exploreController.responseModel.value.data ?? [];

                  if (dataList.isEmpty) {
                    return const Center(child: Text("No cities found"));
                  }

                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: dataList.length + 1,
                    itemBuilder: (context, index) {
                      if (index == dataList.length) {
                        return Container(
                          height: 44,
                          margin: const EdgeInsets.only(top: 2, bottom: 16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE2EBFF),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            'Load more · page 2 of 3',
                            style: TextStyle(
                              color: Color(0xFF326BFF),
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }

                      final city = dataList[index];

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
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

  // City card widget builder
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