import 'package:get/get.dart';
import 'package:minbus_weather_app/Model/CitiesModel.dart';
import 'package:minbus_weather_app/Services/Api_services/Api_Servcies.dart';
import 'package:minbus_weather_app/Services/Api_services/Api_endpoints.dart';

class Explorecontroller extends GetxController {
  // 1. Make variables reactive using .obs
  RxBool isLoading = false.obs;
  RxBool isMoreLoading = false.obs;
  Rx<GetCtiesModel> responseModel = GetCtiesModel().obs;
  RxList<Datum> listofcities = <Datum>[].obs;


  // Define the regions list
  final List<String> regions = [
    'All',
    'Asia',
    'Europe',
    'Africa',
    'North America',
    'South America',
    'Oceania',
  ];

  RxString selectedRegion = 'All'.obs;

  @override
  void onInit() {
    super.onInit();
    getCities(1, 4);
  }

  void selectRegion(String region) {
    selectedRegion.value = region;
  }

  Future<void> getCities(int pages, int limit) async {
    try {
      if (pages == 1) {
        isLoading.value = true;
      } else {
        isMoreLoading.value = true;
      }

      var responseFromAPI = await ApiServcies().getMethod(
        ApiEndpoints.getCiteisurl(pages, limit),
      );

      print("RAW API RESPONSE: $responseFromAPI");

      responseModel.value = getCtiesModelFromJson(responseFromAPI);


      if (pages == 1) {
        listofcities.clear();
      }

      if (responseModel.value.data != null) {
        listofcities.addAll(responseModel.value.data!);
      }

      isLoading.value = false;
      isMoreLoading.value = false;
    } catch (e, stackTrace) {
      isLoading.value = false;
      isMoreLoading.value = false;
      print("PARSING ERROR: $e");
      print(stackTrace);

      Get.snackbar("Error", e.toString());
    }
  }
}