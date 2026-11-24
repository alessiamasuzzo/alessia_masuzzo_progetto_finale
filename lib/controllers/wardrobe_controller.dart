import 'package:alessia_masuzzo_progetto_finale/models/categories.dart';
import 'package:alessia_masuzzo_progetto_finale/models/clothing_item.dart';
import 'package:flutter/material.dart';

class WardrobeController extends ChangeNotifier {


  final List<ClothingItem> _clothes = [
  ClothingItem(
    imageUrl: "https://placehold.co/400x500.png?text=Gonna",
    name: "Gonna plissettata",
    category: "Scuola",
    season: "Autunno",
    favorite: false,
  ),
  ClothingItem(
    imageUrl: "https://placehold.co/400x500.png?text=Jeans",
    name: "Jeans a vita alta",
    category: "Scuola",
    season: "Tutte",
    favorite: false,
  ),
  ClothingItem(
    imageUrl: "https://placehold.co/400x500.png?text=Felpa",
    name: "Felpa con cappuccio",
    category: "Scuola",
    season: "Inverno",
    favorite: false,
  ),
  ClothingItem(
    imageUrl: "https://placehold.co/400x500.png?text=T-shirt",
    name: "T-shirt basic",
    category: "Scuola",
    season: "Estate",
    favorite: false,
  ),
  ClothingItem(
    imageUrl: "https://placehold.co/400x500.png?text=Camicia",
    name: "Camicia bianca",
    category: "Lavoro",
    season: "Primavera",
    favorite: false,
  ),
  ClothingItem(
    imageUrl: "https://placehold.co/400x500.png?text=Pantaloni",
    name: "Pantaloni sartoriali",
    category: "Lavoro",
    season: "Autunno",
    favorite: false,
  ),
  ClothingItem(
    imageUrl: "https://placehold.co/400x500.png?text=Blazer",
    name: "Blazer grigio",
    category: "Lavoro",
    season: "Inverno",
    favorite: false,
  ),
  ClothingItem(
    imageUrl: "https://placehold.co/400x500.png?text=Tailleur",
    name: "Tailleur nero",
    category: "Lavoro",
    season: "Autunno",
    favorite: false,
  ),
  ClothingItem(
    imageUrl: "https://placehold.co/400x500.png?text=Abito+lungo",
    name: "Abito lungo",
    category: "Elegante",
    season: "Estate",
    favorite: false,
  ),
  ClothingItem(
    imageUrl: "https://placehold.co/400x500.png?text=Vestito+sera",
    name: "Vestito da sera",
    category: "Elegante",
    season: "Inverno",
    favorite: false,
  ),
  ClothingItem(
    imageUrl: "https://placehold.co/400x500.png?text=Decollete",
    name: "Décolleté nere",
    category: "Elegante",
    season: "Tutte",
    favorite: false,
  ),
  ClothingItem(
    imageUrl: "https://placehold.co/400x500.png?text=Cappotto",
    name: "Cappotto beige",
    category: "Elegante",
    season: "Inverno",
    favorite: false,
  ),
];

List<ClothingItem> get clothes => List.unmodifiable(_clothes);

List<ClothingItem> get favorite =>  _clothes.where((c) => c.favorite).toList();

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

}