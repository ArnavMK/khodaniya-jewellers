import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:khodaniya_jewellers/screens/screens.dart';
import 'package:khodaniya_jewellers/constants/constants.dart';
import 'package:stock_repository/stock_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await Firebase.initializeApp();
  LocalStockDatabase.instance.initialize(); 

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Khodaniya Jwellers',
      theme: ThemeData(
        fontFamily: 'Poppins'
      ),
      home: SplashScreen(),
      routes: {
        AppRoutes.splash: (context) => const SplashScreen(),
        AppRoutes.login: (context) => const LoginScreen(),
        AppRoutes.register: (context) => const RegisterScreen(),
        AppRoutes.home: (context) => const HomeScreen(),
        // AppRoutes.profile: (context) => const ProfileScreen(),
        // AppRoutes.settings: (context) => const SettingsScreen(),
        // AppRoutes.itemDetails: (context) => const ItemDetailsScreen(),
      },
    ),
  );
}


