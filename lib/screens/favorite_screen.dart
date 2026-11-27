import 'package:alessia_masuzzo_progetto_finale/controllers/favorites_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Preferiti",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: context.watch<FavoritesController>().favorites.isEmpty
          ? const Center(child: Text("Non hai ancora nessun preferito"))
          : ListView.separated(
              itemCount: context.watch<FavoritesController>().favorites.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final p = context.watch<FavoritesController>().favorites[index];

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 16,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          p.thumbnail,
                          width: 90,
                          height: 110,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stack) => Container(
                            width: 90,
                            height: 110,
                            color: Theme.of(context).colorScheme.outline,
                            child: const Icon(Icons.image_outlined, size: 32),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              p.title,
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              p.description,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => context
                            .read<FavoritesController>()
                            .toggleFavorite(p),
                        icon: Icon(
                          Icons.bookmark,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}