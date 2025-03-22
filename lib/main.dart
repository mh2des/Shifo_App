import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shifo_app/routes.dart';
import 'package:shifo_app/theme/app_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'firebase_options.dart';
void main() async {
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,

        // Localization delegates for Arabic
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ar'),
        ],
        locale: const Locale('ar'),

        title: 'شيفو', 
        theme: AppTheme.lightTheme, 

        initialRoute: AppRoutes.welcome,
        getPages: AppRoutes.routes,
      ),
    );
  }
}
