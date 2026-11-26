import 'dart:typed_data';
import 'package:alessia_masuzzo_progetto_finale/controllers/wardrobe_controller.dart';
import 'package:alessia_masuzzo_progetto_finale/models/categories.dart';
import 'package:alessia_masuzzo_progetto_finale/models/seasons.dart';
import 'package:alessia_masuzzo_progetto_finale/theme/app_colors.dart';
import 'package:alessia_masuzzo_progetto_finale/models/blob_background.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddClothingScreen extends StatefulWidget {
  const AddClothingScreen({super.key});

  @override
  State<AddClothingScreen> createState() => _AddClothingScreenState();
}

class _AddClothingScreenState extends State<AddClothingScreen> {
  final _addClothingKey = GlobalKey<FormState>();

  String? _seasonSelected;

  String? _categorySelected;

  String _nameClothing = "";

  Uint8List? _image;

  // cambia a ogni salvataggio: ricrea i campi e li svuota
  int _formVersion = 0;

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "Inserisci il nome del capo";
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
          title: Text("Form", style: Theme.of(context).textTheme.headlineMedium),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _addClothingKey,
                child: Column(
                  key: ValueKey(_formVersion),
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // foto
                    FormField<Uint8List>(
                      validator: (value) =>
                          value == null ? "La foto è obbligatoria" : null,
                      onSaved: (value) => _image = value,
                      builder: (state) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: () async {
                              final file = await ImagePicker().pickImage(
                                source: ImageSource.gallery,
                                maxWidth: 800,
                                imageQuality: 80,
                              );
                              if (file == null) return;
                              final bytes = await file.readAsBytes();
                              if (!state.mounted) return;
                              state.didChange(bytes);
                            },
                            child: Container(
                              height: 180,
                              width: double.infinity,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surface,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: state.hasError
                                      ? Theme.of(context).colorScheme.error
                                      : AppColors.lightBorderDefault,
                                ),
                              ),
                              child: state.value == null
                                  ? Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      spacing: 8,
                                      children: [
                                        Icon(
                                          Icons.add_photo_alternate_outlined,
                                          size: 40,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                        const Text("Aggiungi una foto"),
                                      ],
                                    )
                                  : Image.memory(
                                      state.value!,
                                      fit: BoxFit.cover,
                                    ),
                            ),
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

                    const SizedBox(height: 25),

                    Text(
                      "Inserisci il nome",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      onSaved: (newValue) => _nameClothing = newValue ?? "",
                      validator: _validateName,
                      decoration: InputDecoration(
                        hintText: "Inserisci il nome del capo",
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

                    const SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () {
                          if (_addClothingKey.currentState!.validate()) {
                            _addClothingKey.currentState!.save();

                            context.read<WardrobeController>().addClothing(
                                  name: _nameClothing.trim(),
                                  category: _categorySelected!,
                                  season: _seasonSelected!,
                                  image: _image!,
                                );

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Capo aggiunto")),
                            );

                            setState(() {
                              _seasonSelected = null;
                              _categorySelected = null;
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