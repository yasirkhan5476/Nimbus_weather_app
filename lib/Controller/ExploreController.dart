import 'package:get/get.dart';
import 'package:minbus_weather_app/Model/CitiesModel.dart';
import 'package:minbus_weather_app/Services/Api_services/Api_Servcies.dart';
import 'package:minbus_weather_app/Services/Api_services/Api_endpoints.dart';

class Explorecontroller extends GetxController {
  bool isLoading = false;
  GetCtiesModel responseModel = GetCtiesModel();
  List<Datum> listofcities = [];

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


  String selectedRegion = 'All';

  @override
  void onInit() {
    super.onInit();
    getCities(1, 4);
  }


  void selectRegion(String region) {
    selectedRegion = region;
    update();
  }

  Future<void> getCities(int pages, int limit) async {
    try {
      isLoading = true;
      update(); // Show loading indicator

      var responseFromAPI = await ApiServcies().getMethod(
        ApiEndpoints.getCiteisurl(pages, limit),
      );

      print("RAW API RESPONSE: $responseFromAPI");


        responseModel = getCtiesModelFromJson(responseFromAPI);
      for(var elements in responseModel.data!){
        listofcities.add(elements);
      }
      isLoading = false;
      update();
    } catch (e, stackTrace) {
      isLoading = false;
      update();
      print("PARSING ERROR: $e");
      print(stackTrace);

      Get.snackbar("Error", e.toString());
    }
  }
}