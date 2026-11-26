class Product {
  final int id;
  final String title;
  final String description;
  final String category;
  final String thumbnail;

  Product({required this.id, required this.title, required this.category, required this.description, required this.thumbnail});

  factory Product.fromJson(Map<String, dynamic> json) {

    return Product(
      id: json['id'] as int, 
      title: json['title'] as String, 
      category: json['category'] as String, 
      description: json['description'] as String, 
      thumbnail: json['thumbnail'] as String);
  }
}