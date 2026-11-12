import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minbus_weather_app/Model/CitiesModel.dart';
import 'package:minbus_weather_app/Services/Api_services/Api_Servcies.dart';
import 'package:minbus_weather_app/Services/Api_services/Api_endpoints.dart';

class SearchController extends GetxController {
  RxBool isLoading = false.obs;
  GetCtiesModel searchCities = GetCtiesModel();
  RxList<Datum> listofSearchcities = <Datum>[].obs; // Note exact naming matching your screen
  Meta searchMetadata = Meta();

  // Added text editing controller for input binding
  final TextEditingController textEditingController = TextEditingController();

  // Added search query observable for Obx checks
  RxString searchQuery = ''.obs;

  Future<void> getSearch(String query) async {
    searchQuery.value = query;

    if (query.trim().isEmpty) {
      listofSearchcities.clear();
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
        listofSearchcities.assignAll(respVar.data!);
      } else {
        listofSearchcities.clear();
      }
    } catch (e) {
      listofSearchcities.clear();
      print("Search Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    textEditingController.dispose();
    super.onClose();
  }
}