import 'package:get/get.dart';
import 'package:minbus_weather_app/Services/Api_services/Api_Servcies.dart';
import 'package:minbus_weather_app/Services/Api_services/Api_endpoints.dart';

import '../Model/city_details_model.dart';
import '../Model/city_forecast_model.dart';
import '../Model/city_places_model.dart';
import '../Model/city_weather_model.dart';

class CityDetailsController extends GetxController {
  CityDetailsController({required this.cityName});

  final String cityName;

  late final String citySlug = cityName.trim().toLowerCase().replaceAll(
    RegExp(r'\s+'),
    '-',
  );

  @override
  void onInit() {
    super.onInit();
    loadCityDetails();
    loadCityWeather();
    loadCityForecast(5);
    loadCityPlaces();
  }

  // Loading flags
  RxBool isLoadingDetails = false.obs;
  RxBool isLoadingWeather = false.obs;
  RxBool isLoadingForecast = false.obs;
  RxBool isLoadingPlaces = false.obs;
  RxBool isLoadingFav = false.obs;

  // Data observables
  Rx<CityDetails?> cityDetails = Rx<CityDetails?>(null);
  Rx<CityWeather?> cityWeather = Rx<CityWeather?>(null);
  RxList<ForecastDay> forecastList = <ForecastDay>[].obs;
  RxList<Place> placesList = <Place>[].obs;

  RxBool isFavorite = false.obs;

  void loadCityDetails() async {
    try {
      isLoadingDetails.value = true;
      var responseFromAPI = await ApiServcies().getMethod(
        ApiEndpoints.getCitiesdetails(citySlug),
      );
      CityDetailsModel responseModel = cityDetailsModelFromJson(
        responseFromAPI,
      );
      cityDetails.value = responseModel.data;
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoadingDetails.value = false;
    }
  }

  void loadCityWeather() async {
    try {
      isLoadingWeather.value = true;
      var responseFromAPI = await ApiServcies().getMethod(
        ApiEndpoints.getCityWeatherUrl(citySlug),
      );
      CityWeatherModel responseModel = cityWeatherModelFromJson(
        responseFromAPI,
      );
      cityWeather.value = responseModel.data;
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoadingWeather.value = false;
    }
  }

  void loadCityForecast(int days) async {
    try {
      isLoadingForecast.value = true;
      var responseFromAPI = await ApiServcies().getMethod(
        ApiEndpoints.getCityForecastUrl(citySlug, days),
      );
      CityForecastModel responseModel = cityForecastModelFromJson(
        responseFromAPI,
      );
      forecastList.value = responseModel.data ?? [];
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoadingForecast.value = false;
    }
  }

  void loadCityPlaces() async {
    try {
      isLoadingPlaces.value = true;
      var responseFromAPI = await ApiServcies().getMethod(
        ApiEndpoints.getCityPlacesUrl(citySlug),
      );
      CityPlacesModel responseModel = cityPlacesModelFromJson(
        responseFromAPI,
      );
      placesList.value = responseModel.data ?? [];
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoadingPlaces.value = false;
    }
  }

  void toggleFavorite() {
    isFavorite.value = !isFavorite.value;
    if (isFavorite.value) {
      Get.snackbar("Favorites", "Added to favorites!");
    } else {
      Get.snackbar("Favorites", "Removed from favorites!");
    }
  }
}