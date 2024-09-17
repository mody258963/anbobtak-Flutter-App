import 'package:anbobtak/costanse/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: MyColors.white,appBar: AppBar(
        title: Text('Cart'),
             leading: IconButton(
          icon: Icon(Icons.arrow_back),  // Back arrow icon
          onPressed: () {
            Navigator.pop(context);  // Navigate back when pressed
          },
        ),
      ),),
    );
  }
}