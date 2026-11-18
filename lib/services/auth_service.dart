import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<String?> login(String email, String password) async {
    try {
       await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      //aggiungere shared_preferences per ricordare se l'utente è loggato
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

//aggiungere logout
}

