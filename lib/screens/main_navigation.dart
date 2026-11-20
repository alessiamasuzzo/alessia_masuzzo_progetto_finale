import 'package:alessia_masuzzo_progetto_finale/screens/shop_screen.dart';
import 'package:alessia_masuzzo_progetto_finale/screens/wardrobe_screen.dart';
import 'package:alessia_masuzzo_progetto_finale/screens/weather_screen.dart';
import 'package:flutter/material.dart';

// main.dart (StreamBuilder)
// ├── utente non loggato → LoginScreen
// └── utente loggato → MainNavigation
//                       ├── body: la pagina scelta dall'indice
//                       │     (Consiglio | Armadio | Shop)
//                       └── bottomNavigationBar: la NavigationBar

class MainNavigation extends StatefulWidget{
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

  class _MainNavigationState extends State<MainNavigation>{

    int _index = 1;
    final List<Widget> _pages = [WeatherScreen(), WardrobeScreen(), ShopScreen()];

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_index],
      bottomNavigationBar: NavigationBar(
      selectedIndex: _index,
      onDestinationSelected: (tappedIndex) {
        setState(() {
          _index = tappedIndex;
        });
      },
        destinations: [
          NavigationDestination(icon: Icon(Icons.wb_sunny_outlined), label: "Weather"),
          NavigationDestination(icon: Icon(Icons.checkroom_outlined), label: "Wardrobe"),
          NavigationDestination(icon: Icon(Icons.shopping_bag_outlined), label: "Shop"),
        ],
      ),
    );
  }

  }
