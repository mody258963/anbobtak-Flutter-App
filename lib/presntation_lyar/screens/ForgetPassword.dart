import 'package:anbobtak/costanse/colors.dart';
import 'package:anbobtak/presntation_lyar/widgets/widgets.dart';
import 'package:flutter/material.dart';


class Forgetpassword extends StatefulWidget {
  const Forgetpassword({super.key});

  @override
  State<Forgetpassword> createState() => _ForgetpasswordState();
}

class _ForgetpasswordState extends State<Forgetpassword> {

  Widgets _widgets = Widgets();
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(home:Scaffold(
      body: Column(
        children: [
          // Logo
      _widgets.Logo(context),
          // Email Input
          TextField(
            decoration: InputDecoration(
              labelText: 'Email',
            ),
          ),
          SizedBox(height: 10),
          // Instruction Text
          Text(
            'Send link on your Email to reset the password',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(height: 20),
          // Sign Up Button
          ElevatedButton(
            onPressed: () {
              // Add your sign-up functionality here
            },
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 50), backgroundColor:MyColors.Secondcolor, // Make the button full width
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ), // Button color
            ),
            child: Text('Sign Up', style: TextStyle(fontSize: 16)),
          ),
          SizedBox(height: 20),
          // Go to Sign In Page Text
          GestureDetector(
            onTap: () {
              // Add your sign-in navigation functionality here
            },
            child: RichText(
              text: TextSpan(
                text: 'Go to Sign In Page ',
                style: TextStyle(color: Colors.grey),
                children: [
                  TextSpan(
                    text: 'Sign In',
                    style: TextStyle(
                      color: Color(0xFF007BFF),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),);
  }
}