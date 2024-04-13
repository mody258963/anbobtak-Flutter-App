import 'package:anbobtak/presntation_lyar/widgets/widgets.dart';
import 'package:flutter/material.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key, this.phonenumber});
final phonenumber;
  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  Widgets _widgets = Widgets();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: Column(children: [_widgets.LoginScreenDisign(context)
      
      ],) ,)
    );
  }
}