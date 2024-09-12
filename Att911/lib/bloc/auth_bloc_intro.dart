import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBlocIntro extends Bloc<AuthEvent, AuthState> {
  AuthBlocIntro(super.initialState) {
    on<RegisterUser>((event, emit) => emit(Unauthenticated()));
    on<LoginUser>((event, emit) {
      if (event.password == "senha") {
        emit(Authenticated(username: event.username));
      } else {
        emit(AuthError(message: "Impossível logar com ${event.username}"));
      }
    });
    on<Logout>((event, emit) => emit(Unauthenticated()));
  }
}

abstract class AuthEvent {}

// Definindo eventos
class LoginUser extends AuthEvent {
  final String username;
  final String password;

  LoginUser({required this.username, required this.password});
}

class RegisterUser extends AuthEvent {
  final String username;
  final String password;

  RegisterUser({required this.username, required this.password});
}

class Logout extends AuthEvent {}

abstract class AuthState {}

// Definindo estados
class Unauthenticated extends AuthState {}

class Authenticated extends AuthState {
  final String username;

  Authenticated({required this.username});
}

class AuthError extends AuthState {
  final String message;

  AuthError({required this.message});
}
