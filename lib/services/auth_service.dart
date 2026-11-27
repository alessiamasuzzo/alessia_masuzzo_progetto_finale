import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //login 
  Future<String?> login(String email, String password) async {
    try {
       await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (errore) {
      if (errore.code == "invalid-credential") {
        return "Credenziali errate";
      } else if (errore.code == "network-request-failed") {
        return "Connessione assente";
      }
      return "Accesso non riuscito";
    }
  }
//logout
Future<void> logout() async{
  await FirebaseAuth.instance.signOut();
}
}

