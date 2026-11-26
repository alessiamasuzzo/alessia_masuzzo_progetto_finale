import 'dart:convert';
import 'package:alessia_masuzzo_progetto_finale/models/products.dart';
import 'package:http/http.dart' as http;

Future<List<Product>> getProducts() async {
  final url = "https://dummyjson.com/products?limit=0";
  final response = await http.get(Uri.parse(url));
  List<String> categoryList = [  "tops",
  "womens-dresses",
  "mens-shirts",
  "womens-shoes",
  "mens-shoes",];

  if (response.statusCode == 200 ) {
    final data = jsonDecode(response.body);
    final list = data["products"] as List;
    return list
    .map((p) => Product.fromJson(p as Map<String, dynamic>))
    .where((p) => categoryList.contains(p.category)).toList();
    } else {
    throw Exception("Errore prodotti");
  }
}