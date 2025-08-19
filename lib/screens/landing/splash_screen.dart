import 'package:flutter/material.dart';
import 'package:khodaniya_jewellers/constants/constants.dart';
import 'package:user_repository/user_repository.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    if (UserRepository.instance.isLoggedIn()) {
      print("User is logged in");
      UserRepository.instance.refreshCurrentAppUser();
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context).pushReplacementNamed(AppRoutes.catalog);
      });
    } 
    else {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context).pushReplacementNamed(AppRoutes.register);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/Icon.png",
                width: 150,
                height: 150,
              ),
              const SizedBox(height: 20),
              Text(
                "Khodaniya Jewellers",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              CircularProgressIndicator(color: AppColors.secondary)
            ],
          ),
        ),
      ),
    );
  }
}
