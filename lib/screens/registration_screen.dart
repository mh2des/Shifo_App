import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shifo_app/controllers/auth_controller.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // Controllers for text fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Get the AuthController instance
  final AuthController _authController = Get.put(AuthController());

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            // Background
            Container(
              color: Colors.white,
            ),
            // Top decoration - Red leaf
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                'assets/images/red_leaf.png',
                width: 80,
              ),
            ),
            // Top decoration - Brown leaf
            Positioned(
              top: 0,
              right: 0,
              child: Image.asset(
                'assets/images/brown_leaf.png',
                width: 80,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/images/bottom_decoration.png',
                width: double.infinity,
                fit: BoxFit.fill,
                height: 130,
              ),
            ),            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  // Logo
                  Image.asset(
                    'assets/images/shifo_logo.png',
                    height: 120,
                  ),
                  const SizedBox(height: 30),
                  // Registration label
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6C3428),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'إنشاء حساب جديد',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Form fields
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        // Name field
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: TextField(
                            controller: _nameController,
                            decoration: const InputDecoration(
                              hintText: 'اسم المستخدم',
                              hintStyle: TextStyle(color: Colors.grey),
                              prefixIcon: Icon(Icons.person, color: Color(0xFF6C3428)),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(vertical: 15),
                            ),
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                        const SizedBox(height: 15),
                        // Email field
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: TextField(
                            controller: _emailController,
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
                        const SizedBox(height: 15),
                        // Password field
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: TextField(
                            controller: _passwordController,
                            decoration: const InputDecoration(
                              hintText: 'كلمة المرور',
                              hintStyle: TextStyle(color: Colors.grey),
                              prefixIcon: Icon(Icons.lock, color: Color(0xFF6C3428)),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(vertical: 15),
                            ),
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                            obscureText: true,
                          ),
                        ),
                        const SizedBox(height: 25),
                        // Register button - calls signUp() on AuthController
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              _authController.signUp(
                                _nameController.text,
                                _emailController.text,
                                _passwordController.text,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFE84730),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'تسجيل',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Login link
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'لديك حساب بالفعل؟',
                      style: TextStyle(
                        color: Color(0xFF6C3428),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            // Bottom decoration

          ],
        ),
      ),
    );
  }
}
