import 'package:anbobtak/besnese_logic/email_auth/email_auth_cubit.dart';
import 'package:anbobtak/costanse/pages.dart';
import 'package:anbobtak/presntation_lyar/screens/OtpScreen.dart';
import 'package:anbobtak/presntation_lyar/widgets/widgets.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String dropdownValue = list.first;
  Widgets _widgets = Widgets();
  final TextEditingController phonecontroller = TextEditingController();


  static const List<String> list = <String>['EN', 'AR'];

  Widget _dropbox() {
    return DropdownMenu<String>(
      inputDecorationTheme: InputDecorationTheme(
          floatingLabelAlignment: FloatingLabelAlignment.start),
      initialSelection: list.first,
      onSelected: (String? value) async {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
        final prefs = await SharedPreferences.getInstance();
        if (dropdownValue == 'AR') {
          prefs.remove('lang1');
          prefs.remove('lang2');
          prefs.setString('lang1', 'ar');
          prefs.setString('lang2', 'en');
        } else {
          prefs.remove('lang1');
          prefs.remove('lang2');
          prefs.setString('lang1', 'en');
          prefs.setString('lang2', 'ar');
        }
        print(prefs.getString('lang1'));
        print(prefs.getString('lang2'));
      },
      dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }

  Widget _buildloginAuth() {
    return BlocListener<EmailAuthCubit, EmailAuthState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, EmailAuthState state) {
        if (state is LoginLoading) {}
        if (state is Loginfails) {
          AlertDialog(
            title: Text('dont play with me'),
          );
        }
        if (state is SignupTeacherSuccess) {
          Navigator.maybePop(context);
          Navigator.pushReplacementNamed(context, nav);
        }
      },
      child: Container(),
    );
  }

  Widget _TitleText(String text) {
    return Text(text);
  }

  Widget _Button(onPressed) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
        height: height * 0.10,
        width: width * 0.70,
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text('Sign up'),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _widgets.LoginScreenDisign(context),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    FadeInUp(
                        duration: Duration(milliseconds: 1500),
                        child:_widgets.TitleText("Enter Phone Number", 30)),
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
                          child: Column(
                            children: <Widget>[
                              _widgets.TextFiledLogin(
                                  '+20 | Phone',
                                  phonecontroller,
                                  10,
                                  'Enter 11 Digits',
                                  'Enter 11 Digits',
                                  11,
                                  context),
                            ],
                          ),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    FadeInUp(
                        duration: Duration(milliseconds: 1900),
                        child:_widgets.AppButton((){
                           Navigator.pushNamed(
                                context, otp , arguments: phonecontroller.toString()
            );
                        }, 'Recive OTP')),
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
