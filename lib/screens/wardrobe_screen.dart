import 'package:alessia_masuzzo_progetto_finale/screens/clothes_screen.dart';
import 'package:alessia_masuzzo_progetto_finale/screens/outfit_screen.dart';
import 'package:flutter/material.dart';

class WardrobeScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Armadio", style: Theme.of(context).textTheme.headlineMedium,),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.account_circle_outlined)),
        ]
      ),
      body: Stack(
          children: [
        //  Positioned.fill(child: Image.asset('assets/images/login_bg.jpg', fit: BoxFit.cover),),
        //  Positioned.fill(child: ColoredBox(color: Color(0x99ffffff))),
        Center(
          child: Row(
            children: [
              //card for clothes
              Card(
                margin: EdgeInsets.all(45),
                elevation: 5.0,
              //  shape: RoundedRectangleBorder(
               //   side: BorderSide(
                //    color: Theme.of(context).colorScheme.primary,
              //    )
               // ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ClothesScreen()),
                    );
                  },
                  child: Padding(padding: EdgeInsetsGeometry.all(25),
                  child: Text("Vestiti")),
                ),
),
              Card(
                elevation: 5.0,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OutfitScreen()),
                    );
                  },
                  child: Padding(padding: EdgeInsetsGeometry.all(25),
                  child: Text("Outfit"),),
                ),
)
            ],
          ),

    ),
    ]
    ),
    );
  }
}