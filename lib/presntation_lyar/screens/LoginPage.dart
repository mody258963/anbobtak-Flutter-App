import 'package:anbobtak/besnese_logic/email_auth/email_auth_cubit.dart';
import 'package:anbobtak/costanse/colors.dart';
import 'package:anbobtak/costanse/pages.dart';
import 'package:anbobtak/presntation_lyar/screens/SignUp.dart';
import 'package:anbobtak/presntation_lyar/widgets/widgets.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String dropdownValue = list.first;
  Widgets _widgets = Widgets();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();

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
      listener: (context, EmailAuthState state) async {
        if (state is LoginLoading) {
          _widgets.buildCircularProgressIndicatorDialogV1(context);
        } else if (state is Loginfails) {
          Navigator.of(context, rootNavigator: true).pop();
          // if (Navigator.canPop(context)) {
          //   Navigator.of(context, rootNavigator: true).pop();
          // }
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Don\'t play with '),
              );
            },
          );
        } else if (state is LoginSuccess) {
          final prefs = await SharedPreferences.getInstance();
          String? name = await prefs.getString('name');
          print('=======name4========${name}');
          if (Navigator.canPop(context)) {
            Navigator.of(context, rootNavigator: true).pop();
          }
          Navigator.of(context, rootNavigator: true).pushReplacementNamed(nav,
              arguments: state.name);
        }
      },
      child: Container(),
    );
  }

  Widget _TitleText(String text) {
    return Text(text);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: MyColors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _widgets.Logo(context),
              _buildloginAuth(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
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
                                  color: Colors.lightBlue,
                                  blurRadius: 20,
                                  offset: Offset(0, 10),
                                )
                              ]),
                          child: Column(
                            children: <Widget>[
                              _widgets.TextFiledLogin('Email', emailcontroller,
                                  10, 'Enter Correct Email', context),
                              _widgets.TextFiledLogin(
                                  'Password',
                                  passwordcontroller,
                                  8,
                                  'Short Password',
                                  context),
                            ],
                          ),
                        )),
                    FadeInUp(
                        duration: Duration(milliseconds: 1900),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, forgot);
                                },
                                child: Text(
                                  'Forgot Password ?',
                                  style: TextStyle(color: Colors.grey),
                                )))),
                    FadeInUp(
                        duration: Duration(milliseconds: 1900),
                        child: _widgets.AppButton(() {
                          context.read<EmailAuthCubit>().loginUser(
                              emailcontroller.text, passwordcontroller.text);
                        }, 'Sign In')),
                    SizedBox(
                      height: 30,
                    ),
                    FadeInUp(
                        duration: Duration(milliseconds: 2100),
                        child:
                            _widgets.ThiredParty(FontAwesomeIcons.google, () {
                          context.read<EmailAuthCubit>().googleSignIn();
                        }, 'Google')),
                    SizedBox(
                      height: 20,
                    ),
                    FadeInUp(
                        duration: Duration(milliseconds: 2100),
                        child: _widgets.ThiredParty(
                            FontAwesomeIcons.facebook, () {}, 'Facebook')),
                    FadeInUp(
                        duration: Duration(milliseconds: 2000),
                        child: Center(
                            child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, otp);
                                },
                                child: Text(
                                  "Create Account ?",
                                  style: TextStyle(color: Colors.grey),
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
