import 'package:alessia_masuzzo_progetto_finale/models/categories.dart';
import 'package:alessia_masuzzo_progetto_finale/models/seasons.dart';
import 'package:alessia_masuzzo_progetto_finale/models/blob_background.dart';
import 'package:flutter/material.dart';

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
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