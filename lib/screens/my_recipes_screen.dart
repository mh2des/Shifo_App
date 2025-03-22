import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shifo_app/routes.dart';

class MyRecipesScreen extends StatelessWidget {
  const MyRecipesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(

            appBar: AppBar(
    
      centerTitle: true,
        title: Text(
         "وصفاتي",
          style: TextStyle(color: const Color(0xFFE84730), fontSize: 22,fontWeight: FontWeight.bold),
        ),
        backgroundColor:         const Color(0xFFF6F2E8),

        elevation: 0,
      ),
      body: user == null
          ? Center(child: Text("يجب تسجيل الدخول لعرض الوصفات"))
          : StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(user.uid)
                  .collection("saved_recipes")
                  .orderBy("timestamp", descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text("حدث خطأ: ${snapshot.error}"));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final docs = snapshot.data?.docs ?? [];
                if (docs.isEmpty) {
                  return const Center(child: Text("لا توجد وصفات محفوظة"));
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final recipe = docs[index].data() as Map<String, dynamic>;
                    return GestureDetector(
                      onTap: () {
                        // Navigate to SavedRecipeDetailScreen with the recipe data
                        Get.toNamed(AppRoutes.savedRecipeDetail, arguments: recipe);
                      },
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                recipe["recipe_name"] ?? "اسم الوصفة",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(Icons.access_time, color: Color(0xFFE84730), size: 20),
                                  const SizedBox(width: 4),
                                  Text(
                                    "${recipe["estimated_time"] ?? "?"} دقيقة",
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                (recipe["formatted_recipe"] ?? "").length > 100
                                    ? "${(recipe["formatted_recipe"] ?? "").substring(0, 100)}..."
                                    : recipe["formatted_recipe"] ?? "",
                                style: const TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
