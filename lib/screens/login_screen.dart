import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenstate();
}

class _LoginScreenstate extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //mettere img come sfondo 
        body: Center(
      child: Card(
        margin: EdgeInsetsGeometry.all(20.00),
        color: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: EdgeInsetsGeometry.all(20.00),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                //title
                Text(
                  "Accedi",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                SizedBox(height: 50),

                //email
                TextFormField(
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
                    obscureText: true,
                    decoration: InputDecoration(
                        label: Text("Password"),
                        hint: Text("Inserisci password"),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(),
                        icon: Icon(Icons.lock_outlined),
                        iconColor: Theme.of(context).colorScheme.primary,
                    ),
                ),

                SizedBox(height: 25),

                //button
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Theme.of(context).colorScheme.onPrimary,         
                    ),
                    onPressed: () => {}, child: Text("Accedi"),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
    );

    
  }
}
