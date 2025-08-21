import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khodaniya_jewellers/screens/auth/bloc/auth_bloc.dart';
import 'package:khodaniya_jewellers/screens/screens.dart';
import 'package:khodaniya_jewellers/constants/constants.dart';
import 'package:stock_repository/stock_repository.dart';
import 'package:user_repository/user_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await Firebase.initializeApp();
  LocalStockDatabase.instance.initialize(); 

  runApp(
    BlocProvider<AuthBloc>(
      create: (_) => AuthBloc(UserRepository.instance),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Khodaniya Jwellers',
        theme: ThemeData(
          fontFamily: 'Poppins',
          scaffoldBackgroundColor: AppColors.backgroundColor,
          cardColor: Colors.white,
          colorScheme: ColorScheme.light(
            surface: Colors.white,
            primary: AppColors.primary,
          ),
        ),
        home: const SplashScreen(),
        routes: {
          AppRoutes.splash: (context) => const SplashScreen(),
          AppRoutes.login: (context) => const LoginScreen(),
          AppRoutes.register: (context) => const RegisterScreen(),
          AppRoutes.home: (context) => const HomeScreen(),
          AppRoutes.catalog: (context) => const CatalogScreen(),
          AppRoutes.profile: (context) => const ProfileScreen(),
          AppRoutes.favorites: (context) => const FavoritesScreen(),
          AppRoutes.search: (context) => const SearchScreen(),
        },
      ),
    )
  );
}


