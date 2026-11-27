import 'dart:typed_data';
import 'package:alessia_masuzzo_progetto_finale/models/clothing_item.dart';
import 'package:flutter/material.dart';

class WardrobeController extends ChangeNotifier {

  final List<ClothingItem> _clothes = [];

  List<ClothingItem> get clothes => List.unmodifiable(_clothes);

  List<ClothingItem> get favorite => _clothes.where((c) => c.favorite).toList();

  void addClothing({
    required String name,
    required String category,
    required String season,
    required Uint8List image,
  }) {
    _clothes.add(
      ClothingItem(
        name: name,
        category: category,
        season: season,
        image: image,
        favorite: false,
      ),
    );
    notifyListeners();
  }

  void toggleFavorite(ClothingItem c){
    c.favorite = !c.favorite;
    notifyListeners();
  }

  List<ClothingItem> byCategories(String? category){
    if(category == null){
      return clothes;
    } else {
      return clothes.where((item) => item.category.contains(category)).toList();
    }
  }

  List<ClothingItem> forTemperature(double temperature) {
    List<String> matching;
    if (temperature < 10) {
      matching = ["Inverno"];
    } else if (temperature <= 20) {
      matching = ["Primavera", "Autunno"];
    } else {
      matching = ["Estate"];
    }

    return _clothes
        .where((c) => matching.contains(c.season))
        .toList();
  }
}