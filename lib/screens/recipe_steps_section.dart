import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
class RecipeStepsSection extends StatefulWidget {
  final Map<String, dynamic> recipeData;
  final String formattedRecipe;

  const RecipeStepsSection({
    Key? key,
    required this.recipeData,
    required this.formattedRecipe,
  }) : super(key: key);

  @override
  State<RecipeStepsSection> createState() => _RecipeStepsSectionState();
}

class _RecipeStepsSectionState extends State<RecipeStepsSection> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  // We'll build pages dynamically from recipeData
  // Instead of a fixed 3-page list
  late List<Map<String, dynamic>> pages;

  @override
  void initState() {
    super.initState();
    
    // Extract from widget.recipeData
    final List<dynamic> ingredients = widget.recipeData["ingredients"] ?? [];
    final List<dynamic> instructions = widget.recipeData["instructions"] ?? [];
    final Map<String, dynamic> nutrition = widget.recipeData["nutrition"] ?? {};
    final String recipeName = widget.recipeData["recipe_name"] ?? "";

    // We'll create 3 pages: المكونات, خطوات الطهي, القيمة الغذائية
    pages = [
      {
        "title": "المكونات",
        "body": ingredients.isNotEmpty
          ? ingredients.map((e) => "- $e").join("\n") 
          : "لم يتم توفير مكونات",
      },
      {
        "title": "خطوات الطهي",
        "body": instructions.isNotEmpty
          ? instructions.asMap().entries.map((e) => "${e.key + 1}) ${e.value}").join("\n\n")
          : "لم يتم توفير خطوات الطهي",
      },
      {
        "title": "المعلومات الغذائية",
        "body": """
السعرات الحرارية: ${nutrition["calories"]  ?? "??"} سعرة حرارية
البروتين: ${nutrition["protein"] ?? "??"} غرام
الدهون:${nutrition["fat"] ?? "??"} غرام
الكربوهيدرات: ${nutrition["carbs"] ?? "??"} غرام

$recipeName
""",
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFF6C3428), width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            const SizedBox(height: 8),

            // Top bar: shows the current page's title
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.brown,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                pages[_currentIndex]["title"] ?? "",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 8),

            // PageView for the body content
            SizedBox(
              height: 250,
              child: Directionality(
                textDirection: TextDirection.ltr, // Force LTR scrolling
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: pages.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final bodyText = pages[index]["body"] as String? ?? "لا يوجد نص";
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SingleChildScrollView(
                        child: Text(
                          bodyText,
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            height: 1.5,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Row of Next/Back
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // NEXT first, then BACK (to match your UI order)
                ElevatedButton(
                  onPressed: _currentIndex < pages.length - 1
                      ? () => _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          )
                      : null,
                  child: const Text('التالي'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _currentIndex > 0
                      ? () => _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          )
                      : null,
                  child: const Text('السابق'),
                ),
              ],
            ),

            const SizedBox(height: 8),
            SvgPicture.asset(
              "assets/images/Layer1.svg",
              height: 100,
            ),
         
          ],
        ),
      ),
    );
  }
}
