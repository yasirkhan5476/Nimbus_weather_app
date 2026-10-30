import 'package:get/get.dart';
import 'package:minbus_weather_app/Model/CitiesModel.dart';
import 'package:minbus_weather_app/Services/Api_services/Api_Servcies.dart';
import 'package:minbus_weather_app/Services/Api_services/Api_endpoints.dart';

class Explorecontroller extends GetxController {
  RxBool isLoading = false.obs;
  Rx<GetCtiesModel> responseModel = GetCtiesModel().obs;

  // 1. Define the regions list here
  final List<String> regions = [
    'All',
    'Asia',
    'Europe',
    'Africa',
    'North America',
    'South America',
    'Oceania',
  ];

  // 2. Define selected region observable
  RxString selectedRegion = 'All'.obs;

  @override
  void onInit() {
    super.onInit();
    getCities(1, 10);
  }

  // 3. Define selectRegion method
  void selectRegion(String region) {
    selectedRegion.value = region;
  }

  Future<void> getCities(int pages, int limit) async {
    try {
      isLoading.value = true;
      var responseFromAPI = await ApiServcies().getMethod(
        ApiEndpoints.getCiteisurl(pages, limit),
      );

      if (responseFromAPI != null) {
        responseModel.value = GetCtiesModel.fromJson(responseFromAPI);
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", e.toString());
    }
  }
}