import 'package:alessia_masuzzo_progetto_finale/models/clothing_item.dart';
import 'package:alessia_masuzzo_progetto_finale/models/outfit.dart';
import 'package:flutter/material.dart';

class OutfitController extends ChangeNotifier {
  final List<Outfit> _outfits = [];

  List<Outfit> get outfits => List.unmodifiable(_outfits);

  List<Outfit> get favorite => _outfits.where((o) => o.favorite).toList();

  void addOutfit({
    required String name,
    required String category,
    required String season,
    required List<ClothingItem> items,
  }) {
    _outfits.add(
      Outfit(
        name: name,
        category: category,
        season: season,
        items: items,
        favorite: false,
      ),
    );
    notifyListeners();
  }

  void toggleFavorite(Outfit o) {
    o.favorite = !o.favorite;
    notifyListeners();
  }

  List<Outfit> byCategories(String? category) {
    if (category == null) {
      return outfits;
    } else {
      return outfits.where((o) => o.category == category).toList();
    }
  }
}