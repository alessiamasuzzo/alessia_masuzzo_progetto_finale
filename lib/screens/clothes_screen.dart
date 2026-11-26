import 'package:alessia_masuzzo_progetto_finale/controllers/wardrobe_controller.dart';
import 'package:alessia_masuzzo_progetto_finale/models/categories.dart';
import 'package:alessia_masuzzo_progetto_finale/models/clothing_item.dart';
import 'package:alessia_masuzzo_progetto_finale/screens/add_clothing_screen.dart';
import 'package:alessia_masuzzo_progetto_finale/screens/detail_screen.dart';
import 'package:alessia_masuzzo_progetto_finale/theme/app_colors.dart';
import 'package:alessia_masuzzo_progetto_finale/models/blob_background.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/wardrobe_controller.dart';

class ClothesScreen extends StatefulWidget {
  const ClothesScreen({super.key});

  @override
  State<ClothesScreen> createState() => _ClothesScreenState();
}

class _ClothesScreenState extends State<ClothesScreen> {
  String? _categorySelected;

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
            "Vestiti",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // riga dei preferiti e linea: compaiono solo se c'è almeno un preferito
            if (context.watch<WardrobeController>().favorite.isNotEmpty) ...[
              SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                scrollDirection: Axis.horizontal,
                child: Row(
                  spacing: 8,
                  children: context
                      .watch<WardrobeController>()
                      .favorite
                      .map(
                        (c) => SizedBox(
                          width: 90,
                          height: 110,
                          child: Card(
                            margin: EdgeInsets.zero,
                            clipBehavior: Clip.antiAlias,
                            child: Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Image.memory(
                                        c.image,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        errorBuilder: (context, error, stack) =>
                                            const Icon(
                                              Icons.broken_image_outlined,
                                            ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 4,
                                      ),
                                      child: Text(
                                        c.name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall,
                                      ),
                                    ),
                                  ],
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: IconButton(
                                    visualDensity: VisualDensity.compact,
                                    padding: const EdgeInsets.all(4),
                                    constraints: const BoxConstraints(),
                                    iconSize: 18,
                                    onPressed: () => context
                                        .read<WardrobeController>()
                                        .toggleFavorite(c),
                                    icon: Icon(
                                      Icons.favorite,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              const Divider(),
            ],

            // chip delle categorie
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              scrollDirection: Axis.horizontal,
              child: Row(
                spacing: 8,
                children: categories
                    .map(
                      (catg) => ChoiceChip(
                        label: Text(catg),
                        selected: _categorySelected == catg,
                        showCheckmark: false,
                        shape: const StadiumBorder(),
                        side: BorderSide(
                          color: _categorySelected == catg
                              ? Colors.transparent
                              : AppColors.lightBorderDefault,
                        ),
                        backgroundColor: Theme.of(context).colorScheme.surface,
                        selectedColor: Theme.of(context).colorScheme.secondary,
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        labelPadding: const EdgeInsets.symmetric(horizontal: 6),
                        labelStyle: TextStyle(
                          color: _categorySelected == catg
                              ? Theme.of(context).colorScheme.onPrimary
                              : Theme.of(context).colorScheme.onSecondary,
                        ),
                        onSelected: (_) {
                          setState(() {
                            if (_categorySelected == catg) {
                              _categorySelected = null;
                            } else {
                              _categorySelected = catg;
                            }
                          });
                        },
                      ),
                    )
                    .toList(),
              ),
            ),

            // griglia dei capi
            Expanded(
              child: context.watch<WardrobeController>().clothes.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 8,
                        children: [
                          Icon(
                            Icons.checkroom_outlined,
                            size: 64,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          Text(
                            "Il tuo armadio è vuoto",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          const Text("Carica il tuo primo capo"),
                        ],
                      ),
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: context
                          .watch<WardrobeController>()
                          .byCategories(_categorySelected)
                          .length,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.7,
                          ),
                      itemBuilder: (context, index) {
                        final c = context
                            .watch<WardrobeController>()
                            .byCategories(_categorySelected)[index];

                        return Card(
                          clipBehavior: Clip.antiAlias,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailScreen(detail: c),
                                ),
                              );
                            },
                            child: Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Image.memory(
                                        c.image,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        errorBuilder: (context, error, stack) =>
                                            const Icon(
                                              Icons.broken_image_outlined,
                                            ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Text(
                                        c.name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                      ),
                                    ),
                                  ],
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: IconButton(
                                    onPressed: () => context
                                        .read<WardrobeController>()
                                        .toggleFavorite(c),
                                    icon: Icon(
                                      c.favorite
                                          ? Icons.favorite
                                          : Icons.favorite_border_outlined,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddClothingScreen()),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
