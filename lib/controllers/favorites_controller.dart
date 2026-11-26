import 'package:alessia_masuzzo_progetto_finale/models/products.dart';
import 'package:flutter/material.dart';

class FavoritesController extends ChangeNotifier {
  final List<Product> _favorites = [];

  List<Product> get favorites => List.unmodifiable(_favorites);

  bool isFavorite(Product p) {
    return _favorites.any((f) => f.id == p.id);
  }

  void toggleFavorite(Product p) {
    if (isFavorite(p)) {
      _favorites.removeWhere((f) => f.id == p.id);
    } else {
      _favorites.add(p);
    }
    notifyListeners();
  }
}