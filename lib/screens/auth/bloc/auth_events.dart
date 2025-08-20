import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class AuthEvent {
  const AuthEvent();
}

class AuthEventLogin extends AuthEvent {

  final String email;
  final String password;
  final String name;

  const AuthEventLogin({
    required this.name,
    required this.password,
    required this.email
  });
}

class AuthEventLogOut extends AuthEvent {
  const AuthEventLogOut();
} 

class AuthEventInitialize extends AuthEvent {
  const AuthEventInitialize();
}
