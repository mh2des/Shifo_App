
import 'package:shifo_app/screens/home_screen.dart';
import 'package:shifo_app/screens/my_recipes_screen.dart';
import 'package:shifo_app/screens/profile_screen.dart';
import 'package:shifo_app/screens/recipe_detail_screen.dart';
import 'package:shifo_app/screens/recipe_ready_screen.dart';
import 'package:shifo_app/screens/login_screen.dart';
import 'package:shifo_app/screens/registration_screen.dart';
import 'package:shifo_app/screens/saved_recipe_detail_screen.dart';
import 'package:shifo_app/screens/welcome_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String welcome = '/';
  static const String home = '/home';
  static const String login = '/login';
    static const String profile = '/profile';
    static const String signUp = '/signUp';
    static const String recipeReadyScreen = '/RecipeReadyScreen';
    static const String recipeDetail = '/recipeDetail';
    static const String myRecipes = '/myRecipes';
    static const String savedRecipeDetail = '/savedRecipeDetail';

  static List<GetPage> routes = [
    GetPage(name: welcome, page: () => WelcomeScreen()),
    GetPage(name: login, page: () => LoginScreen()),
    GetPage(name: signUp, page: () => RegistrationScreen()),
    GetPage(name: home, page: () => HomeScreen()),
    GetPage(name: recipeReadyScreen, page: () => RecipeReadyScreen()),
    GetPage(name: recipeDetail, page: () => RecipeDetailScreen()),
    GetPage(name: profile, page: () => ProfileScreen()),
    GetPage(name: myRecipes, page: () => const MyRecipesScreen()),
    GetPage(name: savedRecipeDetail, page: () => const SavedRecipeDetailScreen()),

  ];
}
