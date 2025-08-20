import 'package:flutter/foundation.dart' show immutable;
import 'package:user_repository/user_repository.dart';

@immutable
abstract class AuthState {
  const AuthState();
}

class AuthStateLoading extends AuthState {
  const AuthStateLoading();
}

class AuthStateLoggedIn extends AuthState {

  final AppUser user;

  const AuthStateLoggedIn(this.user); 
}

class AuthStateLoginFaliure extends AuthState {
  final Exception exception;

  const AuthStateLoginFaliure(this.exception);
}

class AuthStateLogoutFaliure extends AuthState {
  final Exception exception;

  const AuthStateLogoutFaliure(this.exception);
}

class AuthStateLoggedOut extends AuthState {

  const AuthStateLoggedOut(); 
}
