import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:permission_handler/permission_handler.dart';

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

  Widget listTile(title, subtitle,BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ListTile(
      title: Padding(
        padding:  EdgeInsets.only(bottom: height * 0.01),
        child: Text(title),
      ),
      contentPadding: EdgeInsets.only(top: height * 0.02,left: width * 0.02),
      titleTextStyle: TextStyle(fontWeight: FontWeight.bold , color: Colors.black,fontSize: width * 0.04),
      subtitleTextStyle: TextStyle(fontWeight: FontWeight.bold , color: Colors.black54),
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

  Future<void> requestLocationPermission() async {
  var status = await Permission.location.request();
  if (status.isGranted) {
    // Permission is granted, proceed
  } else if (status.isDenied) {
    // Permission denied, handle appropriately
  } else if (status.isPermanentlyDenied) {
    // The user opted not to grant permission and should not be asked again
    openAppSettings();  // Opens app settings where user can manually allow permission
  }
}
}
