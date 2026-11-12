import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minbus_weather_app/Controller/FavoriteController.dart';
import 'package:minbus_weather_app/Model/GetFavModel.dart';

class FavoritesScreen extends StatelessWidget {
  FavoritesScreen({super.key});

  final Favoritecontroller controller = Get.put(Favoritecontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F6FF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Screen Header with Add Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Favorites',
                        style: GoogleFonts.sora(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF102344),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Obx(
                            () => Text(
                          '${controller.favouriteslist.length} saved cities',
                          style: GoogleFonts.sora(
                            fontSize: 13,
                            color: const Color(0xFF7183A7),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Action to add city
                    },
                    icon: const Icon(Icons.add, size: 18, color: Colors.white),
                    label: Text(
                      'Add',
                      style: GoogleFonts.sora(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF326BFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Favorites List View
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (controller.favouriteslist.isEmpty) {
                    return Center(
                      child: Text(
                        "No favorites added yet.",
                        style: GoogleFonts.sora(
                          color: const Color(0xFF7183A7),
                          fontSize: 14,
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: controller.favouriteslist.length,
                    itemBuilder: (context, index) {
                      final item = controller.favouriteslist[index];
                      return _buildFavoriteCard(context, item);
                    },
                  );
                }),
              ),

              const SizedBox(height: 12),

              // Yellow Info Note matching design callout
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF4D4),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFFFE599)),
                ),
                child: Text(
                  "Pencil = PATCH the note. Trash = DELETE the favorite. Both need your token.",
                  style: GoogleFonts.sora(
                    fontSize: 12,
                    color: const Color(0xFFB45309),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Favorite Item Card matching Figma layout
  Widget _buildFavoriteCard(BuildContext context, FavouriteList item) {
    TextEditingController noteController = TextEditingController(text: item.candy);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          // Weather Icon container
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: const Color(0xFFFFF2CC),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.wb_sunny_outlined,
              size: 28,
              color: Color(0xFFFFB800),
            ),
          ),
          const SizedBox(width: 14),

          // City Name & Note text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${item.name} ${item.height}", // e.g. Karachi 28°
                  style: GoogleFonts.sora(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF102344),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.edit, size: 12, color: Color(0xFF7183A7)),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        '“${item.candy.isEmpty ? "No note" : item.candy}”',
                        style: GoogleFonts.sora(
                          fontSize: 12,
                          color: const Color(0xFF7183A7),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Pencil Edit Button (PATCH)
          IconButton(
            style: IconButton.styleFrom(
              backgroundColor: const Color(0xFFE2EBFF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            icon: const Icon(Icons.edit_outlined, size: 18, color: Color(0xFF326BFF)),
            onPressed: () {
              // Dialog to edit note (PATCH)
              Get.defaultDialog(
                title: "Edit Note",
                titleStyle: GoogleFonts.sora(fontWeight: FontWeight.bold),
                content: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: noteController,
                    decoration: const InputDecoration(
                      hintText: "Enter custom note",
                    ),
                  ),
                ),
                textConfirm: "Save Note",
                textCancel: "Cancel",
                confirmTextColor: Colors.white,
                buttonColor: const Color(0xFF326BFF),
                onConfirm: () {
                  controller.updateNote(item.id.toString(), noteController.text);
                  Get.back();
                },
              );
            },
          ),

          const SizedBox(width: 6),

          // Trash Delete Button (DELETE)
          IconButton(
            style: IconButton.styleFrom(
              backgroundColor: const Color(0xFFFFE5E5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            icon: const Icon(Icons.delete_outline, size: 18, color: Colors.red),
            onPressed: () {
              // Confirm Delete Dialog
              Get.defaultDialog(
                title: "Delete Favorite",
                middleText: "Are you sure you want to delete ${item.name}?",
                textConfirm: "Delete",
                textCancel: "Cancel",
                confirmTextColor: Colors.white,
                buttonColor: Colors.red,
                onConfirm: () {
                  controller.removeFavorite(item.id.toString());
                  Get.back();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}