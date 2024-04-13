import 'package:anbobtak/costanse/colors.dart';
import 'package:flutter/material.dart';


class EmailScreen extends StatefulWidget {
  const EmailScreen({super.key});

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Scaffold(backgroundColor: MyColors.backcolor,
      body: Center(child: Text('Login'),)
    ),);
  }
}