import 'package:get/get.dart';
import 'package:minbus_weather_app/Model/CitiesModel.dart';
import 'package:minbus_weather_app/Services/Api_services/Api_Servcies.dart';
import 'package:minbus_weather_app/Services/Api_services/Api_endpoints.dart';

class SearchController extends GetxController {
  RxBool isLoading = false.obs;
  GetCtiesModel searchCities = GetCtiesModel();
  RxList<Datum> listofsearchcities = <Datum>[].obs;
  Meta searchMetadata = Meta();

  Future<void> getSearch(String query) async {
    if (query.trim().isEmpty) {
      listofsearchcities.clear();
      return;
    }

    try {
      isLoading.value = true;

      var responseFromApi = await ApiServcies().getMethod(
        ApiEndpoints.Search(query),
      );

      GetCtiesModel respVar = getCtiesModelFromJson(responseFromApi);
      searchMetadata = respVar.meta ?? Meta();

      if (respVar.data != null) {
        listofsearchcities.assignAll(respVar.data!);
      } else {
        listofsearchcities.clear();
      }
    } catch (e) {
      listofsearchcities.clear();
      print("Search Error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}