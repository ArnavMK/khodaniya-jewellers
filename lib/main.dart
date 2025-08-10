import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:khodaniya_jewellers/screens/auth/register_screen.dart';
import 'package:khodaniya_jewellers/screens/landing/splash_screen.dart';
import 'package:khodaniya_jewellers/screens/screens.dart';
import 'package:khodaniya_jewellers/constants/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Khodaniya Jwellers',
      theme: ThemeData(
        fontFamily: 'Poppins'
      ),
      home: SplashScreen(),
      routes: {
        // AppRoutes.splash: (context) => const SplashScreen(),
        AppRoutes.login: (context) => const LoginScreen(),
        AppRoutes.register: (context) => const RegisterScreen(),
        // AppRoutes.profile: (context) => const ProfileScreen(),
        // AppRoutes.settings: (context) => const SettingsScreen(),
        // AppRoutes.itemDetails: (context) => const ItemDetailsScreen(),
      },
    ),
  );
}


