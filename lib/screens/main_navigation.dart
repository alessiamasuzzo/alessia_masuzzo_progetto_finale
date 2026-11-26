import 'package:alessia_masuzzo_progetto_finale/screens/shop_screen.dart';
import 'package:alessia_masuzzo_progetto_finale/screens/wardrobe_screen.dart';
import 'package:alessia_masuzzo_progetto_finale/screens/weather_screen.dart';
import 'package:alessia_masuzzo_progetto_finale/theme/app_colors.dart';
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
      extendBody: true,
      body: _pages[_index],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.lightNavBackground,
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: AppColors.lightBorderDefault),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: NavigationBar(
              backgroundColor: Colors.transparent,
              selectedIndex: _index,
              onDestinationSelected: (tappedIndex) {
                setState(() {
                  _index = tappedIndex;
                });
              },
              destinations: [
                NavigationDestination(icon: Icon(Icons.wb_sunny_outlined), label: "Consiglio"),
                NavigationDestination(icon: Icon(Icons.checkroom_outlined), label: "Armadio"),
                NavigationDestination(icon: Icon(Icons.shopping_bag_outlined), label: "Shop"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  }