import 'package:anbobtak/costanse/colors.dart';
import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({super.key});

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
Widgets _widgets = Widgets();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      home: Scaffold(
        backgroundColor: MyColors.white,body: Container(),),
    );
  }
}