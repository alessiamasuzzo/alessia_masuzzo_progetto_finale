import 'package:alessia_masuzzo_progetto_finale/screens/clothes_screen.dart';
import 'package:alessia_masuzzo_progetto_finale/screens/outfit_screen.dart';
import 'package:alessia_masuzzo_progetto_finale/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class WardrobeScreen extends StatelessWidget {
  const WardrobeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Armadio",
          style: Theme.of(context).textTheme.headlineMedium
              ?.copyWith(color: Theme.of(context).colorScheme.secondary),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
            icon: Icon(Icons.account_circle_outlined),
          ),
        ],
      ),
      body: Stack(
        children: [
      //    Positioned.fill(
//             child: RotatedBox(
//   quarterTurns: 1, // 1 = 90° in senso orario, 2 = 180°, 3 = 270°, 4 = 360°
//   child: Image.asset('assets/images/login_bg.jpg', fit: BoxFit.cover),
// ),
    //     ),
    //     Positioned.fill(child: ColoredBox(color: Color(0x55000000))),
     //   Positioned.fill(child: ColoredBox(color: Color(0x55000000))),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.00),
              child: Row(
                spacing: 50.00,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //card for clothes
                  Expanded(
                    child: Card(
                      color: Theme.of(context).colorScheme.secondary,
                      clipBehavior: Clip.antiAlias,
                      elevation: 5.0,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ClothesScreen(),
                            ),
                          );
                        },
                        child: Center(
                          heightFactor: 20.00,
                          child: Text(
                            "Vestiti",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      color: Theme.of(context).colorScheme.secondary,
                      clipBehavior: Clip.antiAlias,
                      elevation: 5.0,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OutfitScreen(),
                            ),
                          );
                        },
                        child: Center(
                          heightFactor: 20.00,
                          child: Text(
                            "Outfit",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
