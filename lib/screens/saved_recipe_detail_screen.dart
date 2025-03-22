import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shifo_app/routes.dart';

class SavedRecipeDetailScreen extends StatelessWidget {
  const SavedRecipeDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recipe = Get.arguments as Map<String, dynamic>? ?? {};
    final String recipeName = recipe["recipe_name"] ?? "اسم الوصفة غير متوفر";
    final String formattedRecipe = recipe["formatted_recipe"] ?? "";
    final dynamic estimatedTime = recipe["estimated_time"];
    final String timeString = estimatedTime?.toString() ?? "?";
    final List<dynamic> ingredients = recipe["ingredients"] ?? [];
    final List<dynamic> instructions = recipe["instructions"] ?? [];
    final Map<String, dynamic> nutrition = recipe["nutrition"] ?? {};

    return Scaffold(
      appBar: AppBar(
    
      centerTitle: true,
        title: Text(
         "تفاصيل الوصفة",
          style: TextStyle(color: const Color(0xFFE84730), fontSize: 22,fontWeight: FontWeight.bold),
        ),
        backgroundColor:         const Color(0xFFF6F2E8),

        elevation: 0,
      ),
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Recipe name
              Text(
                recipeName,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              // Estimated time
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.access_time, color: Color(0xFFE84730), size: 20),
                  const SizedBox(width: 4),
                  Text(
                    "$timeString دقيقة",
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Formatted recipe text
              Text(
                formattedRecipe,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 16),
              // Ingredients
              Text(
                "المكونات:",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                ingredients.isNotEmpty ? ingredients.join("\n") : "لم يتم توفير المكونات",
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 16),
              // Instructions
              Text(
                "خطوات الطهي:",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                instructions.isNotEmpty ? instructions.join("\n\n") : "لم يتم توفير خطوات الطهي",
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 16),
              // Nutrition info
              Text(
                "المعلومات الغذائية:",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                "السعرات الحرارية: ${nutrition["calories"] ?? "??"} سعرة حرارية\n"
                "البروتين: ${nutrition["protein"] ?? "??"} غرام\n"
                "الدهون: ${nutrition["fat"] ?? "??"} غرام\n"
                "الكربوهيدرات: ${nutrition["carbs"] ?? "??"} غرام",
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton.icon(
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
