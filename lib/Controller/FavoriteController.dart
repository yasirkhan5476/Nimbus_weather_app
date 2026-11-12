import 'package:get/get.dart';
import 'package:minbus_weather_app/Model/GetFavModel.dart';

import '../Services/Api_services/Api_Servcies.dart';
import '../Services/Api_services/Api_endpoints.dart';

class Favoritecontroller extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isfav = false.obs;

  // Changed type from GetFavModel to FavouriteList
  RxList<FavouriteList> favouriteslist = <FavouriteList>[].obs;

  @override
  void onInit() {
    super.onInit();
    getfavorites();
  }

  Future<void> getfavorites() async {
    try {
      isLoading.value = true;
      favouriteslist.clear();

      var responseFromApi = await ApiServcies().getMethod(
        ApiEndpoints.FavoriteUrl,
        requiresToken: true,
      );

      if (responseFromApi != null) {
        GetFavModel getfavModel = getFavModelFromJson(responseFromApi);


        for (var element in getfavModel.pokemon) {
          favouriteslist.add(element);
        }
      }
    } catch (e) {
      print("FAVORITES ERROR: $e");
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
  // Future<void> removeFavorite(String favId) async {
  //   try {
  //     await ApiServcies().d(
  //       "${ApiEndpoints.FavoriteUrl}/$favId",
  //       requiresToken: true,
  //     );
  //     favouriteslist.removeWhere((item) => item.id.toString() == favId);
  //     Get.snackbar("Success", "Removed from favorites!");
  //   } catch (e) {
  //     Get.snackbar("Error", e.toString());
  //   }
  // }

}