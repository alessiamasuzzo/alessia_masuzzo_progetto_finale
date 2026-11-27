import 'package:alessia_masuzzo_progetto_finale/controllers/outfit_controller.dart';
import 'package:alessia_masuzzo_progetto_finale/controllers/wardrobe_controller.dart';
import 'package:alessia_masuzzo_progetto_finale/models/categories.dart';
import 'package:alessia_masuzzo_progetto_finale/models/clothing_item.dart';
import 'package:alessia_masuzzo_progetto_finale/models/seasons.dart';
import 'package:alessia_masuzzo_progetto_finale/theme/app_colors.dart';
import 'package:alessia_masuzzo_progetto_finale/models/blob_background.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddOutfitScreen extends StatefulWidget {
  const AddOutfitScreen({super.key});

  @override
  State<AddOutfitScreen> createState() => _AddOutfitScreenState();
}

class _AddOutfitScreenState extends State<AddOutfitScreen> {
  final _addOutfitKey = GlobalKey<FormState>();

  String? _seasonSelected;

  String? _categorySelected;

  String _nameOutfit = "";

  final Set<ClothingItem> _selected = {};

  int _formVersion = 0;

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "Inserisci il nome dell'outfit";
    }
    return null;
  }

  String? _validateDropdown(String? value) {
    if (value == null || value.isEmpty) {
      return 'Seleziona un\'opzione';
    }
    return null;
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
            "Nuovo outfit",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _addOutfitKey,
                child: Column(
                  key: ValueKey(_formVersion),
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Inserisci il nome",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      onSaved: (newValue) => _nameOutfit = newValue ?? "",
                      validator: _validateName,
                      decoration: InputDecoration(
                        hintText: "Outfit 1",
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.surface,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    Text(
                      "Seleziona la stagione",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      initialValue: _seasonSelected,
                      borderRadius: BorderRadius.circular(16),
                      decoration: InputDecoration(
                        hintText: 'Seleziona una voce',
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.surface,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      items: seasons.map((String valore) {
                        return DropdownMenuItem<String>(
                          value: valore,
                          child: Text(valore),
                        );
                      }).toList(),
                      onChanged: (String? nuovoValore) {
                        setState(() {
                          _seasonSelected = nuovoValore;
                        });
                      },
                      validator: _validateDropdown,
                    ),

                    const SizedBox(height: 25),

                    Text(
                      "Seleziona la categoria",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      initialValue: _categorySelected,
                      borderRadius: BorderRadius.circular(16),
                      decoration: InputDecoration(
                        hintText: 'Seleziona una voce',
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.surface,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      items: categories.map((String valore) {
                        return DropdownMenuItem<String>(
                          value: valore,
                          child: Text(valore),
                        );
                      }).toList(),
                      onChanged: (String? nuovoValore) {
                        setState(() {
                          _categorySelected = nuovoValore;
                        });
                      },
                      validator: _validateDropdown,
                    ),

                    const SizedBox(height: 25),

                    Text(
                      "Seleziona i capi (almeno 2)",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(height: 8),

                    FormField<int>(
                      initialValue: 0,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (_) =>
                          _selected.length < 2 ? "Seleziona almeno 2 capi" : null,
                      builder: (state) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                context.watch<WardrobeController>().clothes.length,
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 140,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 0.75,
                            ),
                            itemBuilder: (context, index) {
                              final c = context
                                  .watch<WardrobeController>()
                                  .clothes[index];

                              return Card(
                                margin: EdgeInsets.zero,
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  side: BorderSide(
                                    color: _selected.contains(c)
                                        ? Theme.of(context).colorScheme.secondary
                                        : AppColors.lightBorderDefault,
                                    width: _selected.contains(c) ? 2 : 1,
                                  ),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (_selected.contains(c)) {
                                        _selected.remove(c);
                                      } else {
                                        _selected.add(c);
                                      }
                                    });
                                    state.didChange(_selected.length);
                                  },
                                  child: Stack(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Image.memory(
                                              c.image,
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8),
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
                                      if (_selected.contains(c))
                                        Positioned(
                                          top: 4,
                                          right: 4,
                                          child: Icon(
                                            Icons.check_circle,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          if (state.hasError)
                            Padding(
                              padding: const EdgeInsets.only(top: 6, left: 12),
                              child: Text(
                                state.errorText!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: Theme.of(context).colorScheme.error,
                                    ),
                              ),
                            ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () {
                          if (_addOutfitKey.currentState!.validate()) {
                            _addOutfitKey.currentState!.save();

                            context.read<OutfitController>().addOutfit(
                                  name: _nameOutfit.trim(),
                                  category: _categorySelected!,
                                  season: _seasonSelected!,
                                  items: _selected.toList(),
                                );

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Outfit creato")),
                            );

                            setState(() {
                              _seasonSelected = null;
                              _categorySelected = null;
                              _selected.clear();
                              _formVersion++;
                            });
                          }
                        },
                        child: const Text("Salva"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}