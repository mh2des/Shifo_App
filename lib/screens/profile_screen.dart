import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shifo_app/routes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String username = 'جارٍ التحميل...';
  String email = 'جارٍ التحميل...';

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        setState(() {
          username = userDoc['username'] ?? 'لا يوجد اسم';
          email = userDoc['email'] ?? 'لا يوجد بريد';
          usernameController.text = username;
          emailController.text = email;
        });
      }
    } catch (e) {
      setState(() {
        username = 'خطأ';
        email = 'خطأ';
      });
      Get.snackbar(
        "خطأ",
        "فشل تحميل بيانات المستخدم: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> _saveUserProfile() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        bool isUpdated = false;

        if (usernameController.text.trim() != username) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .update({'username': usernameController.text.trim()});
          isUpdated = true;
        }

        if (emailController.text.trim() != email) {
          await user.updateEmail(emailController.text.trim());
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .update({'email': emailController.text.trim()});
          isUpdated = true;
        }

        if (isUpdated) {
          Get.snackbar(
            "نجاح",
            "تم تحديث الملف الشخصي بنجاح!",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          _loadUserProfile();
        } else {
          Get.snackbar(
            "لا توجد تعديلات",
            "لم يتم تعديل أي حقل.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.blue,
            colorText: Colors.white,
          );
        }
      }
    } catch (e) {
      Get.snackbar(
        "خطأ",
        "فشل حفظ الملف الشخصي: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'هل أنت متأكد؟',
            style: TextStyle(fontWeight: FontWeight.bold),
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
                'إلغاء',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(        backgroundColor:         const Color(0xFFF6F2E8),

      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'الملف الشخصي',
          style: TextStyle(color: const Color(0xFFE84730), fontSize: 22,fontWeight: FontWeight.bold),
        ),
        backgroundColor:         const Color(0xFFF6F2E8),

        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ListView(
            children: [
              const SizedBox(height: 20),
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: const Color(0xFFE84730),
                      child: const Icon(
                        Icons.person,
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      username,
                      style: TextStyle(
                        color: const Color(0xFFE84730),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      email,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'تحديث الملف الشخصي',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff005546),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: TextField(
                        controller: usernameController,
                        decoration: const InputDecoration(
                          hintText: 'اسم المستخدم أو البريد',
                          hintStyle: TextStyle(color: Colors.grey),
                          prefixIcon: Icon(Icons.person, color: Color(0xFF6C3428)),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 15),
                        ),
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: TextField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          hintText: 'البريد الإلكتروني',
                          hintStyle: TextStyle(color: Colors.grey),
                          prefixIcon: Icon(Icons.email, color: Color(0xFF6C3428)),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 15),
                        ),
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(8),
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            _showLogoutDialog(context);
                          },
                          child: Text(
                            'تسجيل الخروج',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(                            padding: const EdgeInsets.all(8),

                            backgroundColor: const Color(0xff00B98D),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: _saveUserProfile,
                          child: Text(
                            'حفظ التغييرات',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
