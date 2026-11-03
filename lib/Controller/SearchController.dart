import 'package:get/get.dart';
import 'package:minbus_weather_app/Model/CitiesModel.dart';
import 'package:minbus_weather_app/Services/Api_services/Api_Servcies.dart';
import 'package:minbus_weather_app/Services/Api_services/Api_endpoints.dart';

class Searchcontroller extends GetxController {
  RxBool isLoading = false.obs;
  GetCtiesModel searchCities = GetCtiesModel();
  RxList<Datum> listofsearchcities = <Datum>[].obs;
  Meta searchMetadata = Meta();

  Future<void> getSearch(String query) async {
    // If the search query is empty, clear the list immediately
    if (query.trim().isEmpty) {
      listofsearchcities.clear();
      update();
      return;
    }

    try {
      isLoading.value = true;
      update();

      var responseFromApi = await ApiServcies().getMethod(
        ApiEndpoints.Search(query),
      );

      GetCtiesModel respVar = getCtiesModelFromJson(responseFromApi);
      searchMetadata = respVar.meta ?? Meta();

      listofsearchcities.clear();
      if (respVar.data != null) {
        listofsearchcities.addAll(respVar.data!);
      }

      print("list of search cities: $listofsearchcities");
      print("Search API Response: $responseFromApi");

      isLoading.value = false;
      update();
    } catch (e) {
      isLoading.value = false;
      listofsearchcities.clear();
      update();
      print("Search Error: $e");
      Get.snackbar("Search Error", e.toString());
    }
  }
}