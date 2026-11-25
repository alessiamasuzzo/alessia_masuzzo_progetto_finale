import 'package:alessia_masuzzo_progetto_finale/controllers/wardrobe_controller.dart';
import 'package:alessia_masuzzo_progetto_finale/models/categories.dart';
import 'package:alessia_masuzzo_progetto_finale/models/clothing_item.dart';
import 'package:alessia_masuzzo_progetto_finale/screens/add_clothing_screen.dart';
import 'package:alessia_masuzzo_progetto_finale/screens/detail_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/wardrobe_controller.dart';


class ClothesScreen extends StatefulWidget{
  const ClothesScreen({super.key});

@override
State<ClothesScreen> createState() => _ClothesScreenState();
}

class _ClothesScreenState extends State<ClothesScreen> {
  String? _categorySelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Vestiti",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child:
            Row(
              spacing: 5.00,
            children: context.watch<WardrobeController>().favorite
            .map((c) => Card(child: Column(
              children: [
                Text(c.name), Icon(
                c.favorite ? Icons.favorite : Icons.favorite_border_outlined,
                color: c.favorite
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).colorScheme.secondary),
              ],
            ),))
            .toList(),
          ),
           ),
        Divider(),
        SingleChildScrollView(
          padding: const EdgeInsets.all(20),
  scrollDirection: Axis.horizontal,
  child: Row(
    spacing: 20,
    children: categories
    .map((catg)
     => ChoiceChip(label: Text(catg), selected: _categorySelected == catg, onSelected: (_) {
      setState(() {
        if(_categorySelected == catg){

        _categorySelected = null;
        } 
        else {
          _categorySelected = catg;
        }
      });
     } )).toList(),
  ),
),
      Expanded(child: 
      
      GridView.builder(
        itemCount: context.watch<WardrobeController>().byCategories(_categorySelected).length,
gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  crossAxisCount: 2,
  crossAxisSpacing: 10,
  mainAxisSpacing: 10,
  childAspectRatio: 0.7,
),
itemBuilder: (context, index) {
  final c = context.watch<WardrobeController>().byCategories(_categorySelected)[index];

  return Card(
    clipBehavior: Clip.antiAlias,
    child: InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(detail: c),
          ),
        );
      },
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Image.network(
                  c.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stack) =>
                      const Icon(Icons.broken_image_outlined),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(c.name),
                    Text(c.category),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: () =>
                  context.read<WardrobeController>().toggleFavorite(c),
              icon: Icon(
                c.favorite ? Icons.favorite : Icons.favorite_border_outlined,
                color: c.favorite
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}, ), ), ], ), 
  floatingActionButton: FloatingActionButton(onPressed: () {
    Navigator.push(context, 
      MaterialPageRoute(builder: (context) => AddClothingScreen()));
  },
  child: Icon(Icons.add),),
); }
}