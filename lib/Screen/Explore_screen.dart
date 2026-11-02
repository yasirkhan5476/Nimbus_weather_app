import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:minbus_weather_app/Controller/ExploreController.dart';
import 'package:minbus_weather_app/Utils/Appicons.dart';

class ExploreScreen extends StatelessWidget {
  ExploreScreen({super.key});

  // Register the controller
  final Explorecontroller exploreController = Get.put(Explorecontroller());

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

              // Search bar
              Container(
                height: 52,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFDCE5F8)),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.search, color: Color(0xFF60769C)),
                    SizedBox(width: 12),
                    Text(
                      'Search cities or countries...',
                      style: TextStyle(fontSize: 14, color: Color(0xFF8B9BB8)),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Region filters wrapped in GetBuilder
              SizedBox(
                height: 45,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: GetBuilder<Explorecontroller>(
                    builder: (controller) => Row(
                      children: controller.regions.map((region) {
                        final bool selected = controller.selectedRegion == region;

                        return GestureDetector(
                          onTap: () => controller.selectRegion(region),
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

              // Cities heading & results count
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
                  GetBuilder<Explorecontroller>(
                    builder: (controller) => Text(
                      '${controller.responseModel.data?.length ?? 0} results',
                      style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              Expanded(
                child: GetBuilder<Explorecontroller>(
                  builder: (controller) {
                    if (controller.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final dataList = controller.responseModel.data ?? [];
                    final meta = controller.responseModel.meta;
                    int pagenumber = meta?.page ?? 0;
                    int totalpages = meta?.totalPages ?? 0;
                    int nextPages = pagenumber+1;

                    if (dataList.isEmpty) {
                      return const Center(
                        child: Text(
                          "No cities found",
                          style: TextStyle(color: Color(0xFF7183A7), fontSize: 14),
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: dataList.length + 1,
                      itemBuilder: (context, index) {
                        // Load more section footer
                        if (index == exploreController.listofcities.length){
                          return InkWell(
                            onTap: (){
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
                  },
                ),
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