import 'package:alessia_masuzzo_progetto_finale/models/categories.dart';
import 'package:alessia_masuzzo_progetto_finale/models/seasons.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Form", style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: Padding(
            padding: EdgeInsetsGeometry.all(20.00),
            child: Form(
              key: _addClothingKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Inserisci il nome"),
                  TextFormField(
                    onSaved: (newValue) => _nameClothing = newValue ?? "",
                    validator: _validateName,
                    decoration: InputDecoration(
                      // label: Text("Nome capo"),
                      hint: Text("Inserisci il nome del capo"),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(),
                    ),
                  ),

                  SizedBox(height: 25),

                  Text("Seleziona la stagione"),
                  DropdownButtonFormField<String>(
                    initialValue: _seasonSelected,
                    decoration: const InputDecoration(
                      hintText: 'Seleziona una voce',
                      border: OutlineInputBorder(),
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

                  SizedBox(height: 25),

                  Text("Seleziona la categoria"),
                  DropdownButtonFormField<String>(
                    initialValue: _categorySelected,
                    decoration: const InputDecoration(
                      hintText: 'Seleziona una voce',
                      border: OutlineInputBorder(),
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
      );
  }
}
