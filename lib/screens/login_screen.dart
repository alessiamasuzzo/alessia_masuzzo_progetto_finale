import 'package:alessia_masuzzo_progetto_finale/screens/main_navigation.dart';
import 'package:alessia_masuzzo_progetto_finale/services/auth_service.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  
  @override
  State<LoginScreen> createState() => _LoginScreenstate();
}

class _LoginScreenstate extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService();


  bool _hidePassword = true;

  String _userPassword = "";
  String _userEmail = "";

  String? _validateEmail(String? value){
    if(value == null || value.isEmpty){
      return "Inserisci l'email corretta";
    } 
    final cleanedEmail = value.trim();
    if (!cleanedEmail.contains("@") || (!cleanedEmail.contains(".it") && !cleanedEmail.contains(".com"))){
      return "Email non valida";
    }
    return null;
  }

   String? _validatePassword(String? value){
    if(value == null || value.isEmpty ){
      return "La password non è valida";
    } if (value.length < 6){
      return "Almeno 6 caratteri";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Positioned.fill(child: Image.asset('assets/images/login_bg.jpg', fit: BoxFit.cover),),
            Positioned.fill(child: ColoredBox(color: Color(0x33000000))),
            Center(
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 2.0,

            ),
        ),
        margin: EdgeInsetsGeometry.all(20.00),
        color: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: EdgeInsetsGeometry.all(20.00),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //title
                Text(
                  "Accedi",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                SizedBox(height: 50),

                //email
                TextFormField(
                  onSaved: (newValue) => _userEmail = newValue ?? "",
                  validator: _validateEmail,
                  decoration: InputDecoration(
                    label: Text("Email"),
                    hint: Text("Inserisci email"),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.email_outlined),
                    iconColor: Theme.of(context).colorScheme.primary,
                  ),
                ),

                SizedBox(height: 50),

                //password
                TextFormField(
                  onSaved: (newValue) => _userPassword = newValue ?? "",
                  validator: _validatePassword,
                    obscureText: _hidePassword,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(onPressed: (){
                        setState(() {
                          _hidePassword = !_hidePassword;
                        });
                      }, 
                      icon: _hidePassword ? Icon(Icons.visibility_outlined) : Icon(Icons.visibility_off_outlined)),
                      suffixIconColor: Theme.of(context).colorScheme.primary, 
                       label: Text("Password"),
                        hint: Text("Inserisci password"),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(),
                        icon: Icon(Icons.lock_outlined),
                        iconColor: Theme.of(context).colorScheme.primary,
                    ),
                ),

                SizedBox(height: 50),

                //button
                FilledButton(
                    onPressed: () async {
                      if(_formKey.currentState!.validate()){
                        _formKey.currentState!.save();

                        final errore = await _authService.login(_userEmail, _userPassword);

                        if(!context.mounted) return;

                        if (errore != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                            content: Text(errore),
                            backgroundColor: const Color.fromARGB(255, 180, 12, 0),
                            ));
                        } else {
                            Navigator.pushReplacement(
                            context, MaterialPageRoute(
                              builder: (context) => const MainNavigation()));
                        }
                      }
                    }, child: Text("Accedi"),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
          ],
        

        )
        
    );

    
  }
}
