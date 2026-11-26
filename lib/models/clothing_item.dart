import 'dart:typed_data';

class ClothingItem{
 Uint8List image;
 String name; 
 String category;
 String season;
 bool favorite;

ClothingItem({
  required this.name, 
  required this.category, 
  required this.favorite,
  required this.image,
  required this.season,
  });
}