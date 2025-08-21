import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khodaniya_jewellers/components/components.dart';
import 'package:khodaniya_jewellers/constants/constants.dart';
import 'package:khodaniya_jewellers/screens/auth/bloc/auth_bloc.dart';
import 'package:khodaniya_jewellers/screens/auth/bloc/auth_events.dart';
import 'package:khodaniya_jewellers/screens/auth/bloc/auth_state.dart';

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
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthStateLoggedIn) {
              Navigator.pushNamedAndRemoveUntil(context, AppRoutes.catalog, (route) => false);
            }
          },
          builder: (context, state) {
            String? errorMessage;
            if (state is AuthStateLoginFaliure) {
              final exception = state.exception;
              if (exception is FirebaseAuthException) {
                switch (exception.code) {
                  case 'user-not-found':
                    errorMessage = "No user found with this email address.";
                    break;
                  case 'wrong-password':
                    errorMessage = "Incorrect password. Please try again.";
                    break;
                  case 'invalid-email':
                    errorMessage = "The email address is not valid. Please enter a valid email.";
                    break;
                  case 'user-disabled':
                    errorMessage = "This account has been disabled. Please contact support.";
                    break;
                  case 'too-many-requests':
                    errorMessage = "Too many failed attempts. Please try again later.";
                    break;
                  case 'invalid-credential':
                    errorMessage = "Wrong credentials. Please try again.";
                    break;
                  default:
                    errorMessage = exception.message ?? "Login failed. Please try again.";
                }
              } else {
                errorMessage = "An unexpected error occurred. Please try again.";
              }
            }

            final bool isLoading = state is AuthStateLoading;

            return SingleChildScrollView(
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
                    
                    if (errorMessage != null) ...[
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
                                  errorMessage,
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
                      onTap: isLoading ? null : _signIn,
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
            );
          },
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

    try {
      if (email.isEmpty || password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please fill in all fields.")),
        );
        return;
      }

      // Dispatch login via Bloc instead of calling repository directly
      context.read<AuthBloc>().add(AuthEventLogin(
        name: "Test user name for now",
        email: email,
        password: password,
      ));
    } catch (e) {
      // Handle any other exceptions
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An unexpected error occurred: $e")),
      );
    }
  }
}

