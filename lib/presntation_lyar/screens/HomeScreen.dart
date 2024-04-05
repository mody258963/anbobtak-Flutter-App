import 'package:anbobtak/costanse/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   Widget _title(String title, BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Text(title,
        style: TextStyle(color: Colors.white, fontSize: width * 0.12));
  }

  @override
  Widget build(BuildContext context) {
        double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return  MaterialApp(home: Scaffold(backgroundColor: MyColors.backcolor,
      body: Column(
        children: [
          Padding(
                      padding:
                          EdgeInsets.only(top: height * 0.06, right: width * 0.40),
                      child: _title('Home', context),
                    ),
        ],
      ),
    ),);
  }
}