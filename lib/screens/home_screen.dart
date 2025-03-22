import 'dart:convert';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shifo_app/routes.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> allIngredients = [
    "طماطم",
    "بصل",
    "بيض",
    "خبز",
    "جبن مالح",
    "فلفل أخضر",
    "كزبرة مفرومة",
    "بصل نوتسبي",
    "فول سوداني",
    "ليمون أخضر",
    "توم أحمر",
    "زبدة مذابة",
  ];

  // User-chosen ingredients
  final List<String> chosenIngredients = [];

  // For custom ingredient entry
  final TextEditingController _ingredientController = TextEditingController();

  // For progress animation
  double _progressValue = 0.0;
  bool _isCooking = false;
  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       
        backgroundColor: const Color(0xFFF6F2E8),
      elevation: 0,),
       drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFFE84730),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  Image.asset('assets/images/shifo_logo.png', width: 80),
                 
                 
                ],
              ),
            ),
            // Profile item
            ListTile(
              leading: const Icon(Icons.person, color: Color(0xFF6C3428)),
              title: const Text('الملف الشخصي'),
              onTap: () {
                Get.toNamed(AppRoutes.profile);
              },
            ),
            // My Recipes item (adjust the route as needed)
            ListTile(
              leading: const Icon(Icons.book, color: Color(0xFF6C3428)),
              title: const Text('وصفاتي'),
              onTap: () {
                       Get.toNamed(AppRoutes.myRecipes);

              },
            ), 
          const Divider(),
          ListTile(
              leading: const Icon(Icons.logout, color: Color(0xFF6C3428)),
              title: const Text('تسجيل الخروج'),
              onTap: () {
                       _showLogoutDialog(context);

              },
            ), 
        
          const SizedBox(height: 10),
          ],
        ),
      ),
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Stack(
            children: [
              Container(color: const Color(0xFFF6F2E8)),
              Align(
                alignment: Alignment.topCenter,
                child: _buildHeader(),
              ),
              Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildInputSection(),
                      const SizedBox(height: 10),
                      _buildCookingProgress(),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset('assets/images/red_leaf.png', width: 80),
          Image.asset('assets/images/brown_leaf.png', width: 80),
        ],
      ),
    );
  }

  Widget _buildInputSection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Center(
            child: Column(
              children: [
                const SizedBox(height: 10),
                SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.asset('assets/images/shifo_logo.png', fit: BoxFit.contain),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE84730),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'شيفو مستعد\nأنشئ وصفاتك الآن',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color(0xFF6C3428), width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              children: [
                SvgPicture.asset(
                  'assets/images/Shape6.svg',
                  fit: BoxFit.fill,
                  colorFilter: const ColorFilter.mode(Colors.white12, BlendMode.dstIn),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        margin: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFeee7e0),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: TextField(
                          controller: _ingredientController,
                          decoration: InputDecoration(
                            hintText: "أدخل المكونات التي لديك يا صديقي",
                            hintStyle: const TextStyle(color: Colors.grey),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: _addCustomIngredient,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                                  child: const Text(
                                    "أضف للأسفل",
                                    style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                          ),
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text("اختر المكونات التي تريد استخدامها:",
                    textAlign: TextAlign.start,
                    textDirection: TextDirection.rtl,
                        style: const TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.bold
                      )),                    const SizedBox(height: 8),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Wrap(
                        spacing: 4,
                        runSpacing: 4,
                        children: allIngredients.map((ingredient) {
                          bool isSelected = chosenIngredients.contains(ingredient);
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (isSelected) {
                                  chosenIngredients.remove(ingredient);
                                } else {
                                  chosenIngredients.add(ingredient);
                                }
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: isSelected ? const Color(0xFF6C3428) : const Color(0xFFDCDCDC),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                ingredient,
                                style: TextStyle(
                                  color: isSelected ? Colors.white : Colors.black87,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 50),
                    _buildExcitedButton(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // When "أضف للأسفل" is tapped, add the custom ingredient
  void _addCustomIngredient() {
    final newIngredient = _ingredientController.text.trim();
    if (newIngredient.isNotEmpty) {
      if (!allIngredients.contains(newIngredient)) {
        setState(() {
          allIngredients.add(newIngredient);
        });
      }
      _ingredientController.clear();
    }
  }

  // Big red button that starts cooking (and later calls the API)
  Widget _buildExcitedButton() {
    return Center(
      child: ElevatedButton(
        onPressed: _startCooking,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE84730),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/shifo_logo.png', width: 24, height: 24),
            const SizedBox(width: 10),
            const Text(
              'إضغط شيفو متحمس للوصفة',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  // Cooking progress with animated progress bar
  Widget _buildCookingProgress() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'انتظر قليلاً وصفاتك',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 8),
            SvgPicture.asset("assets/images/asset.svg", height: 60),
            const SizedBox(width: 8),
            const Text(
              'تطبخ على نار هادئة',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 80),
          padding: const EdgeInsets.all(4),
          height: 35,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF6C3428), width: 2),
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double fillWidth = constraints.maxWidth * _progressValue.clamp(0, 1);
              return Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        color: const Color(0xFFE84730),
                        width: fillWidth,
                        height: 20,
                        child: SvgPicture.asset(
                          'assets/images/Shape6.svg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  // Start cooking animation; when complete, call the API and set data in RecipeController
  void _startCooking() {
    if (_isCooking) return;
    _isCooking = true;
    _progressValue = 0.0;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      setState(() {
        _progressValue += 0.01;
        if (_progressValue >= 1.0) {
          _progressValue = 1.0;
          timer.cancel();
          _isCooking = false;
          _fetchRecipeFromApi();
        }
      });
    });
  }

  // API call to Flask backend; once data is received, store it in RecipeController and navigate
Future<void> _fetchRecipeFromApi() async {
  final String joinedIngredients = chosenIngredients.join(', ');
  if (joinedIngredients.isEmpty) {
    // print("No ingredients selected!");
    return;
  }
  try {
    final url = Uri.parse("https://shifu-app-backend.onrender.com/generate_recipe");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"ingredients": joinedIngredients}),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonBody = jsonDecode(response.body);
      final String formattedRecipe = jsonBody["formatted_recipe"] ?? "";
      final Map<String, dynamic> recipeData = jsonBody["recipe_data"] ?? {};

      // Navigate to RecipeReadyScreen, passing the recipe data
      Get.toNamed(
        AppRoutes.recipeReadyScreen,
        arguments: {
          "formattedRecipe": formattedRecipe,
          "recipeData": recipeData,
        },
      );
    } else {
      print("Error from server: ${response.statusCode}");
    }
  } catch (e) {
    print("Exception while calling API: $e");
  }
}


  @override
  void dispose() {
    _timer?.cancel();
    _ingredientController.dispose();
    super.dispose();
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'هل انت متأكد؟',
            style: TextStyle(color: Colors.red),
          ),
          content: Text(
            'هل تريد تسجيل الخروج بالفعل؟',
            style: TextStyle(color: Colors.black87),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'الغاء',
                            style: TextStyle(color: Colors.black87),

              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red,
              padding: const EdgeInsets.all(8)),

              onPressed: () {
                FirebaseAuth.instance.signOut();
                Get.offAllNamed(AppRoutes.login);
              },
              child: Text(
                'تسجيل الخروج',
                            style: TextStyle(color: Colors.white),

              ),
            ),
          ],
        );
      },
    );
  }
}
