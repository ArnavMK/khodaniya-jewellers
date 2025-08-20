import 'package:flutter_bloc/flutter_bloc.dart';
import './auth_events.dart';
import './auth_state.dart';
import 'package:user_repository/user_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(UserRepository provider) : super(const AuthStateLoading()) {
    on<AuthEventInitialize>((_, emit) async {
      if (provider.isLoggedIn()) {
        print("User is logged in");
        provider.refreshCurrentAppUser();
        await Future.delayed(const Duration(seconds: 2));
        AppUser? user = provider.currentUser;
        if (!emit.isDone) {
          emit(AuthStateLoggedIn(user!));
        }
      } 
      else {
        await Future.delayed(const Duration(seconds: 2));
        if (!emit.isDone) {
          emit(AuthStateLoggedOut());
        }
      }
    });

    on<AuthEventLogin>((event, emit) async {
      final String email = event.email;
      final String password = event.password;
      final String name = event.name;

      try {
        AppUser user = await provider.logIn(email: email, password: password, name: name);
        emit(AuthStateLoggedIn(user));
      }
      on Exception catch (e) {
        emit(AuthStateLoginFaliure(e));
      }
    });

    on<AuthEventLogOut>((event, emit) async {
      try {
        emit(AuthStateLoading());
        await provider.logOut();
        emit(AuthStateLoggedOut());
      }
      on Exception catch (e) {
        emit(AuthStateLogoutFaliure(e));
      }
    });
  }
}
