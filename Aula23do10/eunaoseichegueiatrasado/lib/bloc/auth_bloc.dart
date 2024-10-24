import 'package:eunaoseichegueiatrasado/model/user_model.dart';
import 'package:eunaoseichegueiatrasado/provider/auth_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../provider/auth_provider.dart';
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(Unauthenticated()) {

    FirebaseAuthenticationService.helper.stream.listen(
      (event) {
      
        add(AuthServerEvent(event));
      
      
    });

    on<AuthServerEvent>((event, emit){
      if(event.userModel == null){
        emit(Unauthenticated());
      }
      else{
        emit(Authenticated(username: event.userModel!.uid));
      }
    });

    on<RegisterUser>((RegisterUser event, Emitter emit) async{
      try{
      await FirebaseAuthenticationService.helper.createUserWithEmailAndPassword(
        event.username, 
        event.password);
      } catch(e){
        emit(AuthError(message: "Impossivel logar: ${e.toString()}"));
      }
      
    });
    on<LoginUser>((LoginUser event, Emitter emit) async {
      try{
      await FirebaseAuthenticationService.helper.signInWithEmailAndPassword(
        event.username, 
        event.password);
      } catch(e){
        emit(AuthError(message: "Impossivel logar: ${e.toString()}"));
      }
    });
    on<Logout>((Logout event, Emitter emit) async {
      try{
      FirebaseAuthenticationService.helper.signOut();
      } catch(e){
        emit(AuthError(message: "Impossivel logar: ${e.toString()}"));
      }
    });
  }
}

/*
 Eventos
*/
abstract class AuthEvent {}

class LoginUser extends AuthEvent {
  String username;
  String password;

  LoginUser({required this.username, required this.password});
}

class RegisterUser extends AuthEvent {
  String username;
  String password;

  RegisterUser({required this.username, required this.password});
}

class Logout extends AuthEvent {}

class AuthServerEvent extends AuthEvent {
  UserModel? userModel;

  AuthServerEvent(this.userModel);
}

/*
Estados
*/
abstract class AuthState {}

class Unauthenticated extends AuthState {}

class Authenticated extends AuthState {
  String username;
  Authenticated({required this.username});
}

class AuthError extends AuthState {
  final String message;
  AuthError({required this.message});
}
