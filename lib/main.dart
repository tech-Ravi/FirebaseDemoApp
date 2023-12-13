import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_application/Screens/splash.dart';
import 'package:flutter_demo_application/constant/app_colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: AppColors.kBackgroundColor,
        scaffoldBackgroundColor: AppColors.kBackgroundColor,
      ),
      debugShowCheckedModeBanner: false,
      home: Material(type: MaterialType.transparency, child: SplashScreen()),
    );
  }
}
