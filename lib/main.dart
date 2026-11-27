import 'package:alessia_masuzzo_progetto_finale/controllers/favorites_controller.dart';
import 'package:alessia_masuzzo_progetto_finale/controllers/outfit_controller.dart';
import 'package:alessia_masuzzo_progetto_finale/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import '../theme/app_theme.dart';
import 'controllers/wardrobe_controller.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => OutfitController()),
    ChangeNotifierProvider(create: (_) => WardrobeController()),
    ChangeNotifierProvider(create: (_) => FavoritesController()),
  ],
  child: MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.light,
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    ),
    );
  }
}


 