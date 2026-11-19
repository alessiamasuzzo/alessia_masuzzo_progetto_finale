import 'package:alessia_masuzzo_progetto_finale/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:alessia_masuzzo_progetto_finale/services/auth_service.dart';

import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final String? email =
      FirebaseAuth.instance.currentUser?.email ?? "email@esempio.it";
  final _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profilo",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.only(left: 20, top: 30),
        child: Column(
          spacing: 5,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              radius: 40,
              child: Icon(
                Icons.person,
                size: 40,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            Padding(padding: EdgeInsets.all(5)),
            Text("Email:", style: Theme.of(context).textTheme.labelMedium),
            Text("$email", style: Theme.of(context).textTheme.bodySmall),
            TextButton.icon(
              onPressed: () async {
                await _authService.logout();

                if (!mounted) return;
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  ((route) => false),
                );
              },
              icon: Icon(Icons.exit_to_app_outlined),
              label: Text("Esci"),
            ),
          ],
        ),
      ),
    );
  }
}
