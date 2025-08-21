import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khodaniya_jewellers/constants/constants.dart';
import 'package:khodaniya_jewellers/screens/auth/bloc/auth_bloc.dart';
import 'package:khodaniya_jewellers/screens/auth/bloc/auth_events.dart';
import 'package:khodaniya_jewellers/screens/auth/bloc/auth_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final authBloc = context.read<AuthBloc>();
        authBloc.add(const AuthEventInitialize());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateLoggedIn) {
          Navigator.of(context).pushReplacementNamed(AppRoutes.catalog);
        }
        else if (state is AuthStateLoggedOut) {
          Navigator.of(context).pushReplacementNamed(AppRoutes.login);
        }
      },
      child: Scaffold(
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
                CircularProgressIndicator(color: AppColors.secondary),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
