import 'package:alessia_masuzzo_progetto_finale/models/clothing_item.dart';
import 'package:flutter/material.dart';

class WardrobeController extends ChangeNotifier {


  final List<ClothingItem> _clothes = [
  ClothingItem(
    imageUrl: "https://placehold.co/400x500.png?text=Gonna",
    name: "Gonna plissettata",
    description: "Gonna al ginocchio in tessuto leggero, ideale con una camicia o un maglioncino.",
    category: "Scuola",
    season: "Autunno",
    favorite: false,
  ),
  ClothingItem(
    imageUrl: "https://placehold.co/400x500.png?text=Jeans",
    name: "Jeans a vita alta",
    description: "Jeans dritti blu scuro, comodi per tutto il giorno.",
    category: "Scuola",
    season: "Tutte",
    favorite: false,
  ),
  ClothingItem(
    imageUrl: "https://placehold.co/400x500.png?text=Felpa",
    name: "Felpa con cappuccio",
    description: "Felpa grigia in cotone felpato, perfetta per le giornate fredde.",
    category: "Scuola",
    season: "Inverno",
    favorite: false,
  ),
  ClothingItem(
    imageUrl: "https://placehold.co/400x500.png?text=T-shirt",
    name: "T-shirt basic",
    description: "T-shirt bianca in cotone, si abbina a tutto.",
    category: "Scuola",
    season: "Estate",
    favorite: false,
  ),
  ClothingItem(
    imageUrl: "https://placehold.co/400x500.png?text=Camicia",
    name: "Camicia bianca",
    description: "Camicia classica con colletto, per riunioni e giornate in ufficio.",
    category: "Lavoro",
    season: "Primavera",
    favorite: false,
  ),
  ClothingItem(
    imageUrl: "https://placehold.co/400x500.png?text=Pantaloni",
    name: "Pantaloni sartoriali",
    description: "Pantaloni neri dalla linea pulita, con piega centrale.",
    category: "Lavoro",
    season: "Autunno",
    favorite: false,
  ),
  ClothingItem(
    imageUrl: "https://placehold.co/400x500.png?text=Blazer",
    name: "Blazer grigio",
    description: "Blazer in lana, da indossare sopra camicia o maglia.",
    category: "Lavoro",
    season: "Inverno",
    favorite: false,
  ),
  ClothingItem(
    imageUrl: "https://placehold.co/400x500.png?text=Tailleur",
    name: "Tailleur nero",
    description: "Giacca e pantaloni coordinati, un classico per occasioni formali.",
    category: "Lavoro",
    season: "Autunno",
    favorite: false,
  ),
  ClothingItem(
    imageUrl: "https://placehold.co/400x500.png?text=Abito+lungo",
    name: "Abito lungo",
    description: "Abito fluido color smeraldo, leggero e adatto alla stagione calda.",
    category: "Elegante",
    season: "Estate",
    favorite: false,
  ),
  ClothingItem(
    imageUrl: "https://placehold.co/400x500.png?text=Vestito+sera",
    name: "Vestito da sera",
    description: "Vestito nero con scollo morbido, per cene e cerimonie.",
    category: "Elegante",
    season: "Inverno",
    favorite: false,
  ),
  ClothingItem(
    imageUrl: "https://placehold.co/400x500.png?text=Decollete",
    name: "Décolleté nere",
    description: "Scarpe con tacco medio, abbinabili a qualsiasi abito elegante.",
    category: "Elegante",
    season: "Tutte",
    favorite: false,
  ),
  ClothingItem(
    imageUrl: "https://placehold.co/400x500.png?text=Cappotto",
    name: "Cappotto beige",
    description: "Cappotto lungo in panno, caldo e raffinato.",
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

}