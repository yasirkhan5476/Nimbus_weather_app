import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:minbus_weather_app/Components/Custom_button.dart';
import 'package:minbus_weather_app/Components/MyTextfieldcomponent.dart';
import 'package:minbus_weather_app/Controller/FavoriteController.dart';
import 'package:minbus_weather_app/Model/GetFavModel.dart';
import 'package:minbus_weather_app/Utils/Appcolors.dart';
import 'package:minbus_weather_app/Utils/Appicons.dart';

class FavoritesScreen extends StatelessWidget {
  FavoritesScreen({super.key});

  final favController = Get.put(FavoritesController());
  final TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.colorF3F7FF,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const SizedBox(height: 20),
              _headers(),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: _favoritesListing(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _favoritesListing() {
    final favList = favController.favoritesList;

    return Column(
      children: List.generate(favList.length, (index) {
        final place = favList[index];

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _placeItem(
            Appicons.rain,
            "${place.city!.name} ${place.city!.weather!.temperatureC}°",
            place.note ?? '',
            place,
          ),
        );
      }),
    );
  }

  Widget _placeItem(
    String icon,
    String title,
    String subtitle,
    FavoritesList favoriteList,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Appcolors.pureWhite,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          // Icon Container
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: Appcolors.colorE4ECFF,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(icon, width: 24, height: 24),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontFamily: 'Sora',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          height: 1.0,
                          letterSpacing: 0.7,
                          color: Appcolors.navy,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.edit_outlined,
                            size: 14,
                            color: Appcolors.textSecondary,
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              subtitle,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: 'DM Sans',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Appcolors.textSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 8),

                // Edit Icon
                GestureDetector(
                  onTap: () {
                    openEditFavoritesBottomSheet(favoriteList);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Appcolors.colorE4ECFF,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SvgPicture.asset(Appicons.editIcon),
                  ),
                ),

                const SizedBox(width: 8),

                // Delete Icon
                GestureDetector(
                  onTap: () {
                    openDeleteConfirmationDialog(favoriteList);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Appcolors.colorFFE9EA,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SvgPicture.asset(Appicons.deleteIcon),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void openDeleteConfirmationDialog(FavoritesList favoriteList) {
    Get.dialog(
      AlertDialog(
        backgroundColor: Appcolors.colorFFFFFF,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Appcolors.colorFFE9EA,
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Icon(Icons.delete_outline, size: 25, color: Colors.red),
            ),
            const SizedBox(height: 16),
            Text(
              "Remove ${favoriteList.city!.name}?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Sora',
                fontSize: 20,
                fontWeight: FontWeight.w700,
                height: 1.0,
                letterSpacing: 0.9,
                color: Appcolors.navy,
              ),
            ),
            const SizedBox(height: 30),
            Text(
              "This deletes “${favoriteList.note}” from your favorites.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'DM Sans',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.0,
                letterSpacing: 0.8,
                color: Appcolors.textSecondary,
              ),
            ),
            const SizedBox(height: 30),
            CustomButton(
              buttonColor: Colors.red,
              buttonText: "Delete",
              textColor: Colors.white,
              height: 42,
              fontSize: 14,
              onButtonTap: () {
                favController.deleteFavorite(favoriteList.id!);
                Get.back();
              },
            ),
            const SizedBox(height: 15),
            CustomButton(
              borderColor: Appcolors.colorE1E8F7,
              buttonColor: Appcolors.pureWhite,
              buttonText: "Cancel",
              textColor: Appcolors.navy,
              height: 42,
              fontSize: 14,
              onButtonTap: () => Get.back(),
            ),
          ],
        ),
      ),
      barrierDismissible: true,
    );
  }

  Widget _headers() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Favorites",
              style: TextStyle(
                fontFamily: 'Sora',
                fontSize: 28,
                fontWeight: FontWeight.w800,
                height: 1.0,
                letterSpacing: 0.80,
                color: Appcolors.navy,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "${favController.favoritesList.length} saved cities",
              style: TextStyle(
                fontFamily: 'DM Sans',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.0,
                letterSpacing: 0.80,
                color: Appcolors.textSecondary,
              ),
            ),
          ],
        ),
        CustomButton(
          buttonColor: const Color(0xFF2F6BFF),
          textColor: Appcolors.pureWhite,
          buttonText: "Add",
          prefixIcon: Icons.add,
          height: 38,
          width: 82,
          borderRadius: 999,
          fontSize: 14,
          iconSize: 16,
          onButtonTap: () {},
        ),
      ],
    );
  }

  void openEditFavoritesBottomSheet(FavoritesList favoriteList) {
    // Pre-populate controller with current note text
    noteController.text = favoriteList.note ?? '';

    Get.bottomSheet(
      Container(
        width: double.infinity,
        constraints: BoxConstraints(maxHeight: Get.height * 0.85),
        padding: const EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 15),
        decoration: const BoxDecoration(
          color: Appcolors.colorFFFFFF,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    "Save to favorites",
                    style: TextStyle(
                      fontFamily: 'Sora',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      height: 1.0,
                      letterSpacing: 0.8,
                      color: Appcolors.navy,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Appcolors.colorECEBFA,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(15),
                      child: SvgPicture.asset(
                        Appicons.cancelIcon,
                        width: 18,
                        height: 18,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _placeBottomSheetCityItem(favoriteList),
              const SizedBox(height: 18),
              Row(
                children: [
                  Text(
                    "Note (optional)",
                    style: TextStyle(
                      fontFamily: 'DM Sans',
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      height: 1.0,
                      letterSpacing: 0.8,
                      color: Appcolors.color5A6B8C,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "14/120",
                    style: TextStyle(
                      fontFamily: 'DM Sans',
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      height: 1.0,
                      letterSpacing: 0.8,
                      color: Appcolors.color5A6B8C,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Fixed: Use 'controller' instead of 'textFieldController', removed non-existent 'borderColor'
              Mytextfieldcomponent(
                hintText: "Add a note...",
                controller: noteController,
              ),
              const SizedBox(height: 10),
              CustomButton(
                buttonColor: Appcolors.color2F6BFF,
                buttonText: "Save to favorites",
                textColor: Appcolors.pureWhite,
                prefixIcon: Icons.favorite_border,
                iconSize: 18,
                onButtonTap: () {
                  favController.editFavorite(
                    noteController.text,
                    favoriteList.id!,
                  );
                  Get.back();
                },
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  Widget _placeBottomSheetCityItem(FavoritesList favoriteList) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Appcolors.colorF3F7FF,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          // Icon Container
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: Appcolors.colorE4ECFF,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              Appicons.blueCloudIcon,
              width: 24,
              height: 24,
            ),
          ),

          const SizedBox(width: 12),

          // City Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  favoriteList.city?.name ?? '',
                  style: TextStyle(
                    fontFamily: 'Sora',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    height: 1.0,
                    letterSpacing: 0.8,
                    color: Appcolors.navy,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "${favoriteList.city?.country ?? ''} · Europe",
                  style: TextStyle(
                    fontFamily: 'DM Sans',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    height: 1.0,
                    letterSpacing: 0.8,
                    color: Appcolors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}