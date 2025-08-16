import 'package:firebase_auth/firebase_auth.dart';
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
  
  String? _errorMessage;

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

  void _signIn() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    // Clear any previous error messages
    setState(() {
      _errorMessage = null;
    });

    try {
      if (email.isEmpty || password.isEmpty) {
        setState(() {
          _errorMessage = "Please fill in all fields.";
        });
        return;
      }

      await UserRepository.instance.logIn(
        email: email,
        password: password,
        name: "Test user name for now",
      );
      
      print("User logged in: $email");
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.catalog, (route) => false);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setState(() {
          _errorMessage = "No user found with this email address.";
        });
      } else if (e.code == 'wrong-password') {
        setState(() {
          _errorMessage = "Incorrect password. Please try again.";
        });
      } else if (e.code == 'invalid-email') {
        setState(() {
          _errorMessage = "The email address is not valid. Please enter a valid email.";
        });
      } else if (e.code == 'user-disabled') {
        setState(() {
          _errorMessage = "This account has been disabled. Please contact support.";
        });
      } else if (e.code == 'too-many-requests') {
        setState(() {
          _errorMessage = "Too many failed attempts. Please try again later.";
        });
      } else if (e.code == 'invalid-credential') {
        setState(() {
          _errorMessage = "Wrong credentials. Please try again.";
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

