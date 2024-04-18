import 'package:anbobtak/costanse/colors.dart';
import 'package:anbobtak/costanse/pages.dart';
import 'package:anbobtak/presntation_lyar/widgets/widgets.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key, this.phonenumber});
  final phonenumber;
  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController otpcontroller = TextEditingController();

  Widgets _widgets = Widgets();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: MyColors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _widgets.LoginScreenDisign(context),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    FadeInUp(
                        duration: Duration(milliseconds: 1500),
                        child: _widgets.TitleText("Enter SMS code", 25)),
                    SizedBox(
                      height: 30,
                    ),
                    FadeInUp(
                        duration: Duration(milliseconds: 1700),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              border: Border.all(
                                  color: Color.fromRGBO(196, 135, 198, .3)),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(196, 135, 198, .3),
                                  blurRadius: 20,
                                  offset: Offset(0, 10),
                                )
                              ]),
                          child: _widgets.TextFiledLogin(
                              'Enter OTP',
                              otpcontroller,
                              6,
                              'Enter 6 Digits',
                              'Enter 6 Digits',
                              6,
                              context),
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    FadeInUp(
                        duration: Duration(milliseconds: 1700),
                        child: _widgets.TitleText(
                            'You will recive SMS on +2${widget.phonenumber}',
                            10)),
                    SizedBox(
                      height: 30,
                    ),
                    FadeInUp(
                        duration: Duration(milliseconds: 1900),
                        child: _widgets.AppButton(() {
                          Navigator.pushNamed(context, homescreen);
                        }, 'Submit OTP')),
                    SizedBox(
                      height: 30,
                    ),
                    FadeInUp(
                        duration: Duration(milliseconds: 2000),
                        child: Center(
                            child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Create Account",
                                  style: TextStyle(
                                      color: Color.fromRGBO(49, 39, 79, .6)),
                                )))),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
