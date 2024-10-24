//ligação do app com o authenticator 

import 'package:firebase_auth/firebase_auth.dart';
import '../model/user_model.dart';
class FirebaseAuthenticationService{
  static FirebaseAuthenticationService helper = FirebaseAuthenticationService._createInstance();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance; //singleton do firebase que serve para fazer as requisicoes

  FirebaseAuthenticationService._createInstance(); //cria um construtor privado;

  //
  Future<UserModel?> signInWithEmailAndPassword(
      String email, String password) async {
    UserCredential userCredential = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    User? user = userCredential.user;

    return _userFromFirebaseUser(user);
  }

  Future<UserModel?> createUserWithEmailAndPassword(
      String email, String password) async {
    UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    User? user = userCredential.user;

    return _userFromFirebaseUser(user);
  }

  UserModel? _userFromFirebaseUser(User? user) {
    return user != null ? UserModel(user.uid) : null;
  }

  //dessa forma podemos ver o erro para colocar no try catch
  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

  //Stream
  Stream get stream {
    return _firebaseAuth.userChanges().map(
          (event) => _userFromFirebaseUser(event), //transformamos o resultado 
        ); 
  }
}