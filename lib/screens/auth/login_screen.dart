import 'package:flutter/material.dart';
import 'package:khodaniya_jewellers/components/components.dart';
import 'package:khodaniya_jewellers/constants/constants.dart';
import 'package:user_repository/user_repository.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  late final TextEditingController _emailController; 
  late final TextEditingController _passwordController; 

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 35),
                Image.asset(
                  "assets/images/Icon.png",
                  width: 150,
                  height: 150,
                ),
                const SizedBox(height: 50),
            
                Text("Welcome back!", style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                )),
                const SizedBox(height: 10),
                Text("To the official app for Khodaniya Jewellers", style: Theme.of(context).textTheme.bodySmall),
            
                const SizedBox(height: 50),
                MyTextInput(
                  prefixIcon: Icon(Icons.email_outlined), 
                  hintString: "Email",
                  obscureText: false,
                  controller: _emailController,
                ),
                const SizedBox(height: 10),
                MyTextInput(
                  prefixIcon: Icon(Icons.lock_outlined), 
                  suffixIcon: Icon(Icons.remove_red_eye_outlined),
                  hintString: "Password",
                  obscureText: true,
                  controller: _passwordController,
                ),
                const SizedBox(height: 25),
                LongButton(
                  text: "Sign In", 
                  onTap: _signIn,
                  backgroundColor: AppColors.primary, 
                ),
                const SizedBox(height: 15),
                LongButton(
                  text: "Create account", 
                  onTap: _switchToSignUpSCreen,
                  borderColor: AppColors.primary,
                  backgroundColor: Colors.transparent,
                ),
              ],
            ),
          ),
        ),
      ),
    ); 
  }

  void _switchToSignUpSCreen() {
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.register, (route) => false);
  }

  void _signIn() {
    UserRepository.instance.logIn(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      name: "Test user name for now",
    ).then((user) {
      print("User logged in: ${user.email}");
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.catalog, (route) => false);
    }).catchError((error) {
      print("Error logging in user: $error");
    });
  }
}

