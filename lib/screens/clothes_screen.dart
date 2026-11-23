import 'package:alessia_masuzzo_progetto_finale/models/clothing_item.dart';
import 'package:alessia_masuzzo_progetto_finale/screens/detail_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class ClothesScreen extends StatefulWidget{
  const ClothesScreen({super.key});

@override
State<ClothesScreen> createState() => _ClothesScreenState();
}

class _ClothesScreenState extends State<ClothesScreen> {

  List<ClothingItem> clothes = [
    ClothingItem(name: "Gonna", category: "Uscire", favorite: false),
    ClothingItem(name: "Tailleur", category: "Lavoro", favorite: false),
    ClothingItem(name: "Top sportivo", category: "Sport", favorite: false),
    ClothingItem(name: "Vestito", category: "Uscire", favorite: false),
    ClothingItem(name: "Camicia", category: "Lavoro", favorite: false),
  ];

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
            children: clothes
            .where((c) => c.favorite)
            .map((c) => Card(child: Column(
              children: [
                Text(c.name),
                Text(c.category),
                Icon(c.favorite ? Icons.favorite : Icons.favorite_border_outlined),
              ],
            ),))
            .toList(),
          ),
           ),
        Divider(),
      Expanded(child: 
      
      GridView.builder(
        itemCount: clothes.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          ), 
          itemBuilder: (
            context, index){
              final c = clothes[index];

              return Card(
                child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailScreen(detail: c,),
                            ), );
                        }, 
                        child: Padding(padding: const EdgeInsets.all(16.00),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(c.name),
                    Text(c.category),
                    Positioned(
                      top: 8.00,
                      right: 8.00,
                      child:IconButton(onPressed: () {
                      setState(() {
                        
                      c.favorite = !c.favorite;
                      });
                    }, icon: c.favorite ? Icon(Icons.favorite) : Icon(Icons.favorite_border_outlined))
                    )

                  ],
                ),)
                        ,)
              );
            })
      )
        ],
      ) 
      
      );
  }}