import 'package:alessia_masuzzo_progetto_finale/models/clothing_item.dart';

class Outfit {
  String name;
  String category;
  String season;
  List<ClothingItem> items;
  bool favorite;

  Outfit({
    required this.name,
    required this.category,
    required this.season,
    required this.items,
    required this.favorite,
  });
}