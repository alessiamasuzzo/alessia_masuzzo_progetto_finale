import 'package:alessia_masuzzo_progetto_finale/screens/login_screen.dart';
import 'package:alessia_masuzzo_progetto_finale/theme/app_colors.dart';
import 'package:alessia_masuzzo_progetto_finale/models/blob_background.dart';
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
    return BlobBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          scrolledUnderElevation: 0,
          title: Text(
            "Profilo",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  radius: 44,
                  child: Icon(
                    Icons.person,
                    size: 44,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 28),

              // email in una card, come le altre schermate
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    spacing: 14,
                    children: [
                      Icon(
                        Icons.mail_outline,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Email",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    color: Theme.of(context).colorScheme.outline,
                                  ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              "$email",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  shape: const StadiumBorder(),
                  side: const BorderSide(color: AppColors.lightBorderDefault),
                  foregroundColor: Theme.of(context).colorScheme.primary,
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () async {
                  await _authService.logout();

                  if (!mounted) return;
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    ((route) => false),
                  );
                },
                icon: Icon(Icons.logout_outlined),
                label: Text("Esci"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}