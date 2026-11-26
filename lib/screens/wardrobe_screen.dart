import 'package:alessia_masuzzo_progetto_finale/screens/clothes_screen.dart';
import 'package:alessia_masuzzo_progetto_finale/screens/outfit_screen.dart';
import 'package:alessia_masuzzo_progetto_finale/screens/profile_screen.dart';
import 'package:alessia_masuzzo_progetto_finale/models/blob_background.dart';
import 'package:flutter/material.dart';

class WardrobeScreen extends StatelessWidget {
  const WardrobeScreen({super.key});

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
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.00),
            child: Row(
              spacing: 50.00,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //card for clothes
                Expanded(
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ClothesScreen(),
                          ),
                        );
                      },
                      child: SizedBox(
                        height: 120,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 8,
                          children: [
                            Icon(
                              Icons.checkroom_outlined,
                              size: 40,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            Text("Vestiti"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OutfitScreen(),
                          ),
                        );
                      },
                      child: SizedBox(
                        height: 120,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 8,
                          children: [
                            Icon(
                              Icons.dry_cleaning_outlined,
                              size: 40,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            Text("Outfit"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}