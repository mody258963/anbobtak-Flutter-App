import 'package:anbobtak/costanse/colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: MyColors.backcolor,
          body: Center(
            child: Column(
              children: [
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: ElevatedButton(
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      prefs.remove('user_id');
                    },
                    child: Text('toto')),
              )
            ]),
          )),
    );
  }
}
