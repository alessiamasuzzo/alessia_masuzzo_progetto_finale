import 'package:flutter/material.dart';

class ClothingItem{
 String imageUrl;
 String name; 
 String description;
 String category;
 String season;
 bool favorite;

ClothingItem({
  required this.name, 
  required this.category, 
  required this.favorite,
  required this.description,
  required this.imageUrl,
  required this.season,
  });
}


