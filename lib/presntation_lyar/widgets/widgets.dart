import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class Widgets {
  Widget TextFiledLogin(text, input, int short, String min, String max,
      int long, BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Color.fromRGBO(196, 135, 198, .3)))),
      child: TextFormField(
        validator: (value) {
          if (value!.length > long) {
            return min;
          }
          if (value.length < short) {
            return max;
          } else {
            return null;
          }
        },
        controller: input,
        decoration: InputDecoration(
            hintText: text,
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey.shade700)),
      ),
    );
  }

  Widget LoginScreenDisign(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      height: 400,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: -40,
            height: 400,
            width: width,
            child: FadeInUp(
                duration: Duration(seconds: 1),
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/background.png'),
                          fit: BoxFit.fill)),
                )),
          ),
          Positioned(
            height: 400,
            width: width + 20,
            child: FadeInUp(
                duration: Duration(milliseconds: 1000),
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/background-2.png'),
                          fit: BoxFit.fill)),
                )),
          )
        ],
      ),
    );
  }

  Widget AppButton(OnPressed, text) {
    return MaterialButton(
      onPressed: OnPressed,
      color: Color.fromRGBO(49, 39, 79, 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      height: 50,
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget TitleText(name,int font) {
    return Text(
      name,
      style: TextStyle(
          color: Color.fromRGBO(49, 39, 79, 1),
          fontWeight: FontWeight.bold,
          fontSize: 30),
    );
  }
}
