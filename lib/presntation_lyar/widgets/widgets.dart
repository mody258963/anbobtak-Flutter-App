import 'package:anbobtak/costanse/colors.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Widgets {
  Widget TextFiledLogin(
      text, input, int short, String max, BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Color.fromRGBO(196, 135, 198, .3)))),
      child: TextFormField(
        validator: (value) {
          if (value!.length < short) {
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

  Widget TextFieldinApp(
      TextEditingController controller,
      text,
      int short,
      String min,
      String max,
      int long,
      sizeR,
      sizeL,
      TextInputType type,
      BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(right: width * sizeR, left: width * sizeL),
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
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: MyColors.Secondcolor), // Change the color when focused
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyColors.whitefade),
          ),
          labelText: text,
          labelStyle: TextStyle(color: Colors.black),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
        ),
      ),
    );
  }

  Widget LoginScreenDisign(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      height: 300,
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
                          image: AssetImage('assets/lolo.png'),
                          fit: BoxFit.fill)),
                )),
          ),
        ],
      ),
    );
  }

  Widget AppButton(OnPressed, text) {
    return MaterialButton(
      onPressed: OnPressed,
      color: MyColors.Secondcolor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
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

  Widget ThiredParty(IconData icon , onPressed, text) {
    return Container(
      decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
      width: double.infinity,
      height: 50,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: FaIcon(icon, color: Colors.black),
        label: Text(
          'Continue with $text',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          overlayColor: Colors.white,
          foregroundColor: Colors.white,
          side: BorderSide(color: Colors.white),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget TitleText(name, double font) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        name,
        style: TextStyle(
            color: Color.fromRGBO(49, 39, 79, 1),
            fontWeight: FontWeight.bold,
            fontSize: font),
      ),
    );
  }

  Widget listTile(title, subtitle, BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ListTile(
      title: Padding(
        padding: EdgeInsets.only(bottom: height * 0.01),
        child: Text(title),
      ),
      contentPadding: EdgeInsets.only(top: height * 0.02, left: width * 0.02),
      titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: width * 0.04),
      subtitleTextStyle:
          TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
      subtitle: Text(subtitle),
    );
  }

  // ======================================= Loading Screen Widget

  Widget buildCircularProgressIndicatorDialog(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Takes the full width
      height: MediaQuery.of(context).size.height * 0.70,
      child: CircularProgressIndicator(),
    );
  }

  void _showCircularProgressIndicatorDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.white.withOpacity(0),
      barrierDismissible: false,
      builder: (BuildContext context) {
        // Call the Widget-building function here.
        return buildCircularProgressIndicatorDialog(context);
      },
    );
  }

  void buildCircularProgressIndicatorDialogV1(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(color: Colors.black),
        );
      },
    );
  
  }
//----------------------------------------------------------
  Future<void> requestLocationPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      // Permission is granted, proceed
    } else if (status.isDenied) {
      // Permission denied, handle appropriately
    } else if (status.isPermanentlyDenied) {
      // The user opted not to grant permission and should not be asked again
      openAppSettings(); // Opens app settings where user can manually allow permission
    }
  }

 //LOGO of the main Screen  
  Widget Logo( BuildContext context) {
        double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ClipPath(
clipper: CurvedClipper(),
      child: Container(
        height: height * 0.4,
        decoration: BoxDecoration(
          color: Colors.lightBlue[100],
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Image.asset(
              'assets/logo.png', // Replace with your logo path
              height: 250,
            ),
          ),
        ),
      ),
    );
  }



}
class CurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height * 0.8);
    path.quadraticBezierTo(size.width / 2, size.height, size.width, size.height * 0.7);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
//_----------------------------------------------------
