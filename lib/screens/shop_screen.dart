import 'package:alessia_masuzzo_progetto_finale/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class ShopScreen extends StatefulWidget{
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Shop",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
            },
            icon: Icon(Icons.account_circle_outlined),
          ),
        ],
      ),
      body: Text("Qui chiamata all'api"),);
  }}