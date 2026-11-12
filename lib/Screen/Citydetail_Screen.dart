import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minbus_weather_app/Controller/CityDetailController.dart';
import 'package:minbus_weather_app/Utils/Appcolors.dart';

import '../Model/city_details_model.dart';
import '../Model/city_forecast_model.dart';
import '../Model/city_places_model.dart';

class CityDetailScreen extends StatelessWidget {
  CityDetailScreen({super.key, required this.cityName});
  final String cityName;

  late final CityDetailsController controller = Get.put(
    CityDetailsController(cityName: cityName),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Navigation Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _circleButton(
                    Icons.arrow_back,
                        () => Get.back(),
                  ),
                  Obx(
                        () => _circleButton(
                      controller.isFavorite.value
                          ? Icons.favorite
                          : Icons.favorite_border,
                      controller.toggleFavorite,
                      iconColor: controller.isFavorite.value
                          ? Colors.red
                          : Appcolors.navy,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              // Hero Weather Card
              _heroCard(),
              SizedBox(height: 12.h),

              // Weather Stats (Humidity, Wind, UV Index)
              Obx(() {
                final weather = controller.cityWeather.value;
                return Row(
                  children: [
                    Expanded(
                      child: _statCard(
                        Icons.water_drop_outlined,
                        'Humidity',
                        weather?.humidity != null
                            ? '${weather!.humidity}%'
                            : '--',
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: _statCard(
                        Icons.air,
                        'Wind',
                        weather?.windKph != null
                            ? '${weather!.windKph!.round()} km/h'
                            : '--',
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: _statCard(
                        Icons.wb_sunny_outlined,
                        'UV index',
                        weather?.uvIndex != null
                            ? '${weather!.uvIndex}'
                            : '--',
                      ),
                    ),
                  ],
                );
              }),
              SizedBox(height: 12.h),

              // 5-Day Forecast Card
              _forecastCard(),
              SizedBox(height: 20.h),

              // Things to do Section Title
              Text(
                'Things to do',
                style: GoogleFonts.sora(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: Appcolors.navy,
                ),
              ),
              SizedBox(height: 12.h),

              // Places List
              Obx(() {
                if (controller.isLoadingPlaces.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (controller.placesList.isEmpty) {
                  return Text(
                    'No places found.',
                    style: GoogleFonts.sora(
                      fontSize: 13.sp,
                      color: Appcolors.textSecondary,
                    ),
                  );
                }
                return Column(
                  children: [
                    for (final place in controller.placesList) ...[
                      _placeTile(place),
                      SizedBox(height: 10.h),
                    ],
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _circleButton(
      IconData icon,
      VoidCallback onTap, {
        Color iconColor = Appcolors.navy,
      }) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: 44.r,
        height: 44.r,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 22.r, color: iconColor),
      ),
    );
  }

  Widget _heroCard() {
    final white70 = Colors.white.withOpacity(0.8);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2F6BFF), Color(0xFF4A5FE0)],
        ),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Obx(() {
        final details = controller.cityDetails.value;
        final weather = controller.cityWeather.value;
        final isLoading =
            controller.isLoadingDetails.value || controller.isLoadingWeather.value;

        final locationLine = [
          if (details?.country?.isNotEmpty ?? false) details!.country,
          if (details?.region?.isNotEmpty ?? false) details!.region,
        ].whereType<String>().join(' · ');

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.location_on_outlined, size: 14.r, color: white70),
                SizedBox(width: 4.w),
                Text(
                  locationLine.isNotEmpty ? locationLine : ' ',
                  style: GoogleFonts.sora(fontSize: 12.sp, color: white70),
                ),
              ],
            ),
            SizedBox(height: 6.h),
            Text(
              details?.name ?? cityName,
              style: GoogleFonts.sora(
                fontSize: 28.sp,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 4.h),
            if (isLoading)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: const CircularProgressIndicator(color: Colors.white),
              )
            else
              Row(
                children: [
                  Expanded(
                    child: Text(
                      weather?.temperatureC != null
                          ? '${weather!.temperatureC!.round()}°'
                          : '--°',
                      style: GoogleFonts.sora(
                        fontSize: 64.sp,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -2,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.wb_cloudy_outlined,
                    size: 64.r,
                    color: Colors.white,
                  ),
                ],
              ),
            SizedBox(height: 4.h),
            Text(
              [
                if (weather?.condition?.label != null) weather!.condition!.label,
                if (weather?.feelsLikeC != null)
                  'Feels like ${weather!.feelsLikeC!.round()}°',
              ].whereType<String>().join(' · '),
              style: GoogleFonts.sora(fontSize: 13.sp, color: white70),
            ),
          ],
        );
      }),
    );
  }

  Widget _statCard(IconData icon, String label, String value) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14.r, color: Appcolors.primary),
              SizedBox(width: 4.w),
              Flexible(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.sora(
                    fontSize: 11.sp,
                    color: Appcolors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Text(
            value,
            style: GoogleFonts.sora(
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
              color: Appcolors.navy,
            ),
          ),
        ],
      ),
    );
  }

  Widget _forecastCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '5-day forecast',
            style: GoogleFonts.sora(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: Appcolors.navy,
            ),
          ),
          SizedBox(height: 12.h),
          Obx(() {
            if (controller.isLoadingForecast.value) {
              return const Center(child: CircularProgressIndicator());
            }
            if (controller.forecastList.isEmpty) {
              return Text(
                'No forecast available.',
                style: GoogleFonts.sora(
                  fontSize: 12.sp,
                  color: Appcolors.textSecondary,
                ),
              );
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (final d in controller.forecastList) _forecastDay(d),
              ],
            );
          }),
        ],
      ),
    );
  }

  static const _weekdayNames = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  Widget _forecastDay(ForecastDay d) {
    final label = d.weekday ??
        (d.date != null ? _weekdayNames[d.date!.weekday - 1] : '--');
    final isCloudy = (d.condition?.code ?? '').toLowerCase().contains('cloud');
    return Column(
      children: [
        Text(
          label,
          style: GoogleFonts.sora(
            fontSize: 12.sp,
            color: Appcolors.textSecondary,
          ),
        ),
        SizedBox(height: 6.h),
        Icon(
          isCloudy ? Icons.cloud_outlined : Icons.wb_sunny_outlined,
          size: 24.r,
          color: isCloudy ? Appcolors.primary : const Color(0xFFFFB800),
        ),
        SizedBox(height: 6.h),
        Text(
          d.highC != null ? '${d.highC!.round()}°' : '--°',
          style: GoogleFonts.sora(
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            color: Appcolors.navy,
          ),
        ),
      ],
    );
  }

  Widget _placeTile(Place place) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Container(
            width: 32.r,
            height: 32.r,
            decoration: BoxDecoration(
              color: const Color(0xFFE5EDFF),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              Icons.place_outlined,
              size: 18.r,
              color: Appcolors.primary,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              place.name ?? '',
              style: GoogleFonts.sora(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Appcolors.navy,
              ),
            ),
          ),
          Text(
            place.type ?? '',
            style: GoogleFonts.sora(
              fontSize: 12.sp,
              color: Appcolors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}