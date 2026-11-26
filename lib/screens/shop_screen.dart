import 'package:alessia_masuzzo_progetto_finale/controllers/favorites_controller.dart';
import 'package:alessia_masuzzo_progetto_finale/models/products.dart';
import 'package:alessia_masuzzo_progetto_finale/screens/favorite_screen.dart';
import 'package:alessia_masuzzo_progetto_finale/screens/profile_screen.dart';
import 'package:alessia_masuzzo_progetto_finale/services/products_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  String searchText = "";

  List<Product> products = [];
  bool loading = true;
  String? errorMessage;

  Future<void> _loadProducts() async {
    try {
      final result = await getProducts();

      if (mounted) {
        setState(() {
          loading = false;
          products = result;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          loading = false;
          errorMessage = "Caricamento non riuscito, riprova più tardi";
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  // la zona sotto la ricerca: cambia in base allo stato
  Widget _buildResult(BuildContext context) {
    final filtered = products
        .where((p) => p.title.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
    if (loading) {
      return const Padding(
        padding: EdgeInsets.only(top: 60),
        child: Center(child: CircularProgressIndicator()),
      );
    } else if (errorMessage != null) {
      return Padding(
        padding: const EdgeInsets.only(top: 60),
        child: Center(child: Text(errorMessage!)),
      );
    } else if (products.isEmpty) {
      return const Padding(
        padding: EdgeInsets.only(top: 60),
        child: Center(
          child: Text("Al momento non ci sono vestiti da mostrarti"),
        ),
      );
    } else if (filtered.isEmpty) {
      return const Padding(
        padding: EdgeInsets.only(top: 60),
        child: Center(child: Text("Nessun risultato per la tua ricerca")),
      );
    } else {
      return ListView.separated(
        itemCount: filtered.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          final p = filtered[index];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16,
              children: [
                // immagine del prodotto
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

                // nome e descrizione
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

                // cuore (non ancora collegato)
                IconButton(
                  onPressed: () =>
                      context.read<FavoritesController>().toggleFavorite(p),
                  icon: Icon(
                    context.watch<FavoritesController>().isFavorite(p)
                        ? Icons.favorite
                        : Icons.favorite_border_outlined,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shop", style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
            icon: const Icon(Icons.account_circle_outlined),
          ),
        ],
      ),
      body: Column(
        children: [
          // riga con ricerca e bottone preferiti
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              spacing: 12,
              children: [
                Expanded(
                  child: TextField(
                    onSubmitted: (value) {
                      setState(() {
                        searchText = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "Cerca (dress, shoes...)",
                      prefixIcon: Icon(Icons.search),
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.surface,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
                IconButton.filled(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FavoritesScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.favorite_border_outlined),
                ),
              ],
            ),
          ),

          // zona che cambia: spinner, errore, vuoto o lista
          Expanded(child: _buildResult(context)),
        ],
      ),
    );
  }
}
