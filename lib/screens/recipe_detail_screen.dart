import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shifo_app/routes.dart';
import 'package:shifo_app/screens/recipe_steps_section.dart';

class RecipeDetailScreen extends StatelessWidget {
  const RecipeDetailScreen({Key? key}) : super(key: key);

  Future<void> _saveRecipe(Map<String, dynamic> recipeData, String formattedRecipe) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        Get.snackbar("خطأ", "يجب تسجيل الدخول لحفظ الوصفة",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
        return;
      }
      // Build a document to save
      final recipeDoc = {
        "recipe_name": recipeData["recipe_name"],
        "formatted_recipe": formattedRecipe,
        "estimated_time": recipeData["estimated_time"],
        "ingredients": recipeData["ingredients"],
        "instructions": recipeData["instructions"],
        "nutrition": recipeData["nutrition"],
        "timestamp": FieldValue.serverTimestamp(),
      };

      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .collection("saved_recipes")
          .add(recipeDoc);

      Get.snackbar("نجاح", "تم حفظ الوصفة بنجاح!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    } catch (e) {
      Get.snackbar("خطأ", "فشل حفظ الوصفة: $e",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  Widget _buildRecipeNameBox(Map<String, dynamic> recipeData) {
    final String recipeName = recipeData["recipe_name"] ?? "اسم الوصفة غير متوفر";
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFF6C3428), width: 1),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFE84730),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'اسم الوصفة',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            recipeName,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.brown[700],
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeBox(Map<String, dynamic> recipeData) {
    final dynamic timeValue = recipeData["estimated_time"];
    final String timeString = timeValue?.toString() ?? "?";
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFE84730), width: 2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.access_time, color: Color(0xFFE84730), size: 20),
            const SizedBox(width: 4),
            Text(
              "$timeString دقيقة",
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Retrieve recipe data passed via RecipeController (or Get.arguments)
    final args = Get.arguments as Map<String, dynamic>?; // if using Get.arguments
    final String formattedRecipe = args?["formattedRecipe"] as String? ?? "";
    final Map<String, dynamic> recipeData = args?["recipeData"] as Map<String, dynamic>? ?? {};

    return Scaffold(
      body: Container(
        color: const Color(0xFFF6F2E8),
        child: SafeArea(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: ListView(
              shrinkWrap: true,
              children: [
                // Top decorative leaves
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset('assets/images/red_leaf.png', width: 80),
                      Image.asset('assets/images/brown_leaf.png', width: 80),
                    ],
                  ),
                ),
                // Main recipe icon
                Center(
                  child: SvgPicture.asset(
                    'assets/images/Shape14.svg',
                    width: 150,
                  ),
                ),
                const SizedBox(height: 8),
                // Recipe name container
                _buildRecipeNameBox(recipeData),
                const SizedBox(height: 8),
                // Time container
                _buildTimeBox(recipeData),
                const SizedBox(height: 8),
                // RecipeStepsSection to show detailed pages
                RecipeStepsSection(
                  recipeData: recipeData,
                  formattedRecipe: formattedRecipe,
                ),
                const SizedBox(height: 12),
                // Row with "Save Recipe" and "Return Home" buttons
                Padding(
                          padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () => _saveRecipe(recipeData, formattedRecipe),
                        icon: const Icon(Icons.bookmark, color: Colors.white),
                        label: const Text(
                          "حفظ الوصفة",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE84730),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          padding: const EdgeInsets.all(8),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Return Home button
                      ElevatedButton.icon(
                        onPressed: () {
                          Get.offAllNamed(AppRoutes.home);
                        },
                        icon: const Icon(Icons.home, color: Colors.white),
                        label: const Text(
                          "العودة للصفحة الرئيسية",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE84730),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          padding: const EdgeInsets.all(8),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Bottom decoration
                Image.asset(
                  'assets/images/bottom_decoration.png',
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
