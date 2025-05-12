import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final int? userId; // Now represents WooCommerce customer ID
  final User user;

  AuthAuthenticated(this.userId, this.user);
}

class AuthUnauthenticated extends AuthState {}

class AuthError extends AuthState {
  
  final String message;
  AuthError(this.message);
}
