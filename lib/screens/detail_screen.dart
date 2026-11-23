import 'package:alessia_masuzzo_progetto_finale/models/clothing_item.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.detail});

final ClothingItem detail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dettaglio",
          style: Theme.of(context).textTheme.headlineMedium
              ?.copyWith(color: Theme.of(context).colorScheme.secondary),
        ),
      ),
      body: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                Image.network(detail.imageUrl,
                fit: BoxFit.cover,
                 width: double.infinity),
                Text(detail.name),
                Text(detail.description),
                Text("Stagione: ${detail.season}"),
                Text("Categoria: ${detail.category}"),
          ],
        ),
      ),
       );
      }}