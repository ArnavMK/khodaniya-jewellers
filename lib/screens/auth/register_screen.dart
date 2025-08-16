import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khodaniya_jewellers/components/components.dart';
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
  
  String? _errorMessage;

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
            
                const SizedBox(height: 10),

                if (_errorMessage != null) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.red.shade200),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.warning_amber_rounded,
                            color: Colors.red.shade600,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              _errorMessage!,
                              style: TextStyle(
                                color: Colors.red.shade700,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
                
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

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();  
    final name = _nameController.text.trim();

    // Clear any previous error messages
    setState(() {
      _errorMessage = null;
    });

    try {
      if (email.isEmpty || password.isEmpty || name.isEmpty) {
        setState(() {
          _errorMessage = "Please fill in all fields.";
        });
        return;
      }
      await UserRepository.instance.createUser(email: email, password: password, name: name);
      await UserRepository.instance.logIn(email: email, password: password, name: name);
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.catalog, (route) => false);
    }
    on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        setState(() {
          _errorMessage = "This email is already registered. Please use a different email.";
        });
      } else if (e.code == 'weak-password') {
        setState(() {
          _errorMessage = "The password provided is too weak. Grow some balls and use a mix of charecters";
        });
      } else if (e.code == 'invalid-email') {
        setState(() {
          _errorMessage = "The email address is not valid. Please enter a valid email.";
        });
      } else {
        setState(() {
          _errorMessage = "An unexpected error occurred. Please try again later.";
        });
      }
      print("AUTHEXCEPTION: ${e.code} - ${e.message}");
    } catch (e) {
      // Handle any other exceptions
      setState(() {
        _errorMessage = "An unexpected error occurred: $e";
      });
    }
  }
}

