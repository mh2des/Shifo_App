import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shifo_app/routes.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Called when the user swipes between pages
  void _onPageChanged(int index) {
    debugPrint("Page changed to: $index");
    setState(() {
      _currentPage = index;
    });
  }

  // Called when tapping the arrow button
  void _handleArrowPressed() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // On the last page navigate to login screen
      Get.toNamed(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // Use SafeArea and Column for a top-to-bottom layout
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl, // Overall UI in RTL
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1) Top row with two leaf images
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/red_leaf.png',
                    width: 60,
                  ),
                  Image.asset(
                    'assets/images/brown_leaf.png',
                    width: 60,
                  ),
                ],
              ),
              // 2) Expanded PageView (wrapped in LTR for left-to-right swiping)
              Expanded(
                child: Directionality(
                  textDirection: TextDirection.ltr, // Force LTR for PageView
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: _onPageChanged,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(), // Smooth swiping
                    children: [
                      _buildPage1(),
                      _buildPage2(),
                      _buildPage3(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // 3) Dots indicator
              _buildDotsIndicator(),
              const SizedBox(height: 16),
              // 4) Bottom decoration
              SizedBox(
                height: 130,
                child: Image.asset(
                  'assets/images/bottom_decoration.png',
                  fit: BoxFit.fill,
                  width: double.infinity,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // First Page: Logo + Text
  Widget _buildPage1() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/shifo_logo.png',
            height: 170,
          ),
          const SizedBox(height: 40),
          Container(
            height: 60,
            width: 250,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFE84730),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(width: 3, color: Colors.black),
            ),
            child: const Text(
              'مرحباً بك صديقي',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, color: Colors.white),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFE84730),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFE84730),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_forward, color: Colors.white),
                onPressed: _handleArrowPressed,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Second Page: Logo + Different Text with an arrow button
  Widget _buildPage2() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/shifo_logo.png',
              height: 160,
            ),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: const Color(0xFF6C3428), width: 1),
              ),
              child: Image.asset(
                'assets/images/textimage.png',
                fit: BoxFit.contain,
                height: 150,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFE84730),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFE84730),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_forward, color: Colors.white),
                  onPressed: _handleArrowPressed,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Third Page: Text + arrow button that navigates to login
  Widget _buildPage3() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/shifo_logo.png',
            height: 170,
          ),
          const SizedBox(height: 40),
          Container(
            height: 60,
            width: 250,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFE84730),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(width: 3, color: Colors.black),
            ),
            child: const Text(
              'هيا نبدأ معاً',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, color: Colors.white),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFE84730),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFE84730),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_forward, color: Colors.white),
                onPressed: () {
                  Get.toNamed(AppRoutes.login);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Dots indicator widget
  Widget _buildDotsIndicator() {
    return Directionality(
       textDirection: TextDirection.ltr,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          3, // number of pages
          (index) {
            bool isActive = (index == _currentPage);
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: isActive ? 12 : 8,
              height: isActive ? 12 : 8,
              decoration: BoxDecoration(
                color: isActive ? const Color(0xFFE84730) : Colors.grey[300],
                shape: BoxShape.circle,
              ),
            );
          },
        ),
      ),
    );
  }
}
