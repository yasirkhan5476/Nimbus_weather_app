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
    listofcities.clear();
    String queryRegion = (region == 'All') ? '' : region;
    getCities(1, 4, region: queryRegion);
  }

  Future<void> getCities(int pages, int limit,{String region = ''}) async {
    try {
    isLoading.value=true;
    String currentRegion = region ?? selectedRegion.value;
    String queryRegion = (currentRegion == 'All') ? '' : currentRegion;
    String endpoint = region.isEmpty?ApiEndpoints.getCiteisurl(pages, limit):ApiEndpoints.getCiteisurlbyregion(pages, limit,queryRegion);
    var responseFromApi = await ApiServcies().getMethod(endpoint);

    GetCtiesModel respVar = getCtiesModelFromJson(responseFromApi);
    responseModel.value = respVar;

    if (respVar.data != null) {
      if (pages == 1) {
        listofcities.addAll(respVar.data!);
      } else {
        listofcities.addAll(respVar.data!);
      }
    }
    } catch (e) {

      isLoading.value = false;
      isMoreLoading.value = false;
      print("PARSING ERROR: $e");
      Get.snackbar("Error", e.toString());

    }
  }
}