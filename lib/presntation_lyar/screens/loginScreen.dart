import 'package:anbobtak/costanse/colors.dart';
import 'package:flutter/material.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Scaffold(backgroundColor: MyColors.backcolor,
      body: Center(child: Text('Login'),)
    ),);
  }
}