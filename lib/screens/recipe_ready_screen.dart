import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shifo_app/routes.dart';

class RecipeReadyScreen extends StatelessWidget {
  const RecipeReadyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Stack(
            children: [
              Container(
                color: const Color(0xFFF6F2E8), 
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Top leaves row
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/images/red_leaf.png',
                          width: 80,
                        ),
                        Image.asset(
                          'assets/images/brown_leaf.png',
                          width: 80,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  Center(
                    child: SvgPicture.asset(
                'assets/images/Shape14.svg',
                      width: 180,
                      // fit: BoxFit.contain,
                    ),
                  ),

                  const SizedBox(height: 20),
   Center(
                    child: SvgPicture.asset(
                'assets/images/r1.svg',
                      width: 200,
                      // fit: BoxFit.contain,
                    ),
                  ),
                 

                  const SizedBox(height: 30),


                  Center(
                    child: SvgPicture.asset(
                'assets/images/hand.svg',
                      width: 100,
                      // fit: BoxFit.contain,
                    ),
                  ),

                  const SizedBox(height: 20),

                  InkWell(
                    onTap: () {
  Get.toNamed(
                        AppRoutes.recipeDetail,
                        arguments: Get.arguments,
                      );                    },
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                        ),
                        child:SvgPicture.asset(
                                    'assets/images/r2.svg',
                                    height: 50,
                        // fit: BoxFit.contain,
                      ),
                      ),
                    ),
                  ),

                  const Spacer(),

                  Image.asset(
                    'assets/images/bottom_decoration.png',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
