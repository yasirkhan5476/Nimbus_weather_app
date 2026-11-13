import 'package:get/get.dart';
import 'package:minbus_weather_app/Model/GetFavModel.dart';
import 'package:minbus_weather_app/Services/Api_services/Api_Servcies.dart';
import 'package:minbus_weather_app/Services/Api_services/Api_endpoints.dart';

class FavoritesController extends GetxController {
  RxBool isLoading = false.obs;
  RxInt favoritesListLength = 0.obs;
  RxBool isEditFavoriteLoading = false.obs;
  RxBool isDeleteFavoriteLoading = false.obs;

  RxList<FavoritesList> favoritesList = <FavoritesList>[].obs;

  @override
  void onInit() {
    super.onInit();
    getFavoritesList();
  }

  Future<void> getFavoritesList() async {
    try {
      isLoading.value = true;
      favoritesList.clear();

      // FIXED: Use getMethod since fetching favorites is a GET request
      var response = await ApiServcies().getMethod(
        ApiEndpoints.FavoriteUrl,
        requiresToken: true,
      );

      GetFavorites parsedResponse = getFavoritesFromJson(response);
      if (parsedResponse.data != null) {
        for (var city in parsedResponse.data!) {
          favoritesList.add(city);
        }
      }
      favoritesListLength.value = favoritesList.length;
      print("Response From Favorites List ----> ${parsedResponse.toJson()}");
      print("Length of Favorites List ----> ${favoritesListLength.value}");
    } catch (e, stackTrace) {
      print('Favorites List Error: $e');
      print(stackTrace);
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> editFavorite(String note, int favoriteId) async {
    try {
      print("Note: $note");
      isEditFavoriteLoading.value = true;

      await ApiServcies().patchMethod(
        ApiEndpoints.editFavorite(favoriteId),
        {"note": note},
        requiresToken: true,
      );

      Get.snackbar("Success", "Favorite Edited Successfully");
      await getFavoritesList(); // Refresh list to show updated note
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isEditFavoriteLoading.value = false;
    }
  }

  Future<void> deleteFavorite(int favoriteId) async {
    try {
      print("favoriteId: $favoriteId");
      isDeleteFavoriteLoading.value = true;

      // FIXED: Added deleteMethod back here
      await ApiServcies().deleteMethod(
        ApiEndpoints.deleteFavorite(favoriteId),
        requiresToken: true,
      );

      favoritesList.removeWhere((item) => item.id == favoriteId);
      favoritesListLength.value = favoritesList.length;
      Get.snackbar("Success", "Favorite Deleted Successfully");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isDeleteFavoriteLoading.value = false;
    }
  }
}