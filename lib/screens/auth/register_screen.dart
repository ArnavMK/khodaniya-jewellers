import 'package:flutter/material.dart';
import 'package:khodaniya_jewellers/components/text_input.dart';
import 'package:khodaniya_jewellers/components/long_button.dart';
import 'package:khodaniya_jewellers/constants/constants.dart';
import 'package:user_repository/user_repository.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  late final TextEditingController _emailController; 
  late final TextEditingController _passwordController; 
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
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
            
                Text("Welcome!", style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                )),
                const SizedBox(height: 10),
                Text("To the official app for Khodaniya Jewellers", style: Theme.of(context).textTheme.bodySmall),
            
                const SizedBox(height: 50),
                MyTextInput(
                  prefixIcon: Icon(Icons.manage_accounts_outlined), 
                  hintString: "Username",
                  obscureText: false,
                  controller: _nameController,
                ),
                const SizedBox(height: 10),
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
                  text: "Sign Up", 
                  onTap: _signUp,
                  backgroundColor: Color(0xFF64A0AD),
                ),
                const SizedBox(height: 15),
                LongButton(
                  text: "Already Have an Account? Sign In", 
                  onTap: _switchToSignInSCreen,
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

  void _switchToSignInSCreen() {
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
  }

  void _signUp() async {
    try {
      await UserRepository.instance.createUser(
        email: _emailController.text.trim(), 
        password: _passwordController.text.trim(),
        name: _nameController.text.trim()
      );
    }
    catch (error) {
      print("Error creating user: $error");
    }
  }
}

