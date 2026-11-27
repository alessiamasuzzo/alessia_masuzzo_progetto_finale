import 'package:alessia_masuzzo_progetto_finale/controllers/outfit_controller.dart';
import 'package:alessia_masuzzo_progetto_finale/controllers/wardrobe_controller.dart';
import 'package:alessia_masuzzo_progetto_finale/models/categories.dart';
import 'package:alessia_masuzzo_progetto_finale/models/clothing_item.dart';
import 'package:alessia_masuzzo_progetto_finale/screens/add_outfit_screen.dart';
import 'package:alessia_masuzzo_progetto_finale/screens/outfit_detail_screen.dart';
import 'package:alessia_masuzzo_progetto_finale/theme/app_colors.dart';
import 'package:alessia_masuzzo_progetto_finale/models/blob_background.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OutfitScreen extends StatefulWidget {
  const OutfitScreen({super.key});

  @override
  State<OutfitScreen> createState() => _OutfitScreenState();
}

class _OutfitScreenState extends State<OutfitScreen> {
  String? _categorySelected;

  Widget _collage(List<ClothingItem> items) {
    final shown = items.take(4).toList();

    Widget tile(int i) {
      if (i < shown.length) {
        return Image.memory(
          shown[i].image,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        );
      }
      return Container(color: AppColors.lightBlobPurple);
    }

    if (shown.length == 2) {
      return Row(children: [Expanded(child: tile(0)), Expanded(child: tile(1))]);
    }
    return Column(
      children: [
        Expanded(
          child: Row(children: [Expanded(child: tile(0)), Expanded(child: tile(1))]),
        ),
        Expanded(
          child: Row(children: [Expanded(child: tile(2)), Expanded(child: tile(3))]),
        ),
      ],
    );
  }

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
            "Outfit",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        body: context.watch<OutfitController>().outfits.isEmpty
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 8,
                  children: [
                    Icon(
                      Icons.dry_cleaning_outlined,
                      size: 64,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    Text(
                      "Crea i tuoi abbinamenti",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ],
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (context.watch<OutfitController>().favorite.isNotEmpty) ...[
                    SingleChildScrollView(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        spacing: 8,
                        children: context
                            .watch<OutfitController>()
                            .favorite
                            .map((o) => SizedBox(
                                  width: 90,
                                  height: 110,
                                  child: Card(
                                    margin: EdgeInsets.zero,
                                    clipBehavior: Clip.antiAlias,
                                    child: Stack(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(child: _collage(o.items)),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 6, vertical: 4),
                                              child: Text(
                                                o.name,
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
                                                .read<OutfitController>()
                                                .toggleFavorite(o),
                                            icon: Icon(
                                              Icons.favorite,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                    const Divider(),
                  ],

                  SingleChildScrollView(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      spacing: 8,
                      children: categories
                          .map((catg) => ChoiceChip(
                                label: Text(catg),
                                selected: _categorySelected == catg,
                                showCheckmark: false,
                                shape: const StadiumBorder(),
                                side: BorderSide(
                                  color: _categorySelected == catg
                                      ? Colors.transparent
                                      : AppColors.lightBorderDefault,
                                ),
                                backgroundColor:
                                    Theme.of(context).colorScheme.surface,
                                selectedColor:
                                    Theme.of(context).colorScheme.secondary,
                                padding: const EdgeInsets.symmetric(horizontal: 2),
                                labelPadding:
                                    const EdgeInsets.symmetric(horizontal: 6),
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
                              ))
                          .toList(),
                    ),
                  ),

                  Expanded(
                    child: context
                            .watch<OutfitController>()
                            .byCategories(_categorySelected)
                            .isEmpty
                        ? const Center(
                            child: Text("Nessun outfit in questa categoria"),
                          )
                        : GridView.builder(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 90),
                            itemCount: context
                                .watch<OutfitController>()
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
                              final o = context
                                  .watch<OutfitController>()
                                  .byCategories(_categorySelected)[index];

                              return Card(
                                clipBehavior: Clip.antiAlias,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            OutfitDetailScreen(outfit: o),
                                      ),
                                    );
                                  },
                                  child: Stack(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(child: _collage(o.items)),
                                          Padding(
                                            padding: const EdgeInsets.all(12),
                                            child: Text(
                                              o.name,
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
                                              .read<OutfitController>()
                                              .toggleFavorite(o),
                                          icon: Icon(
                                            o.favorite
                                                ? Icons.favorite
                                                : Icons.favorite_border_outlined,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
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
            if (context.read<WardrobeController>().clothes.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "Il tuo armadio è vuoto. Aggiungi dei capi per creare degli outfit",
                  ),
                ),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddOutfitScreen()),
              );
            }
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}