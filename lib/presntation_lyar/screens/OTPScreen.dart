import 'package:anbobtak/besnese_logic/email_auth/email_auth_cubit.dart';
import 'package:anbobtak/costanse/colors.dart';
import 'package:anbobtak/costanse/pages.dart';
import 'package:anbobtak/presntation_lyar/widgets/widgets.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SecondOTP extends StatefulWidget {
  const SecondOTP({super.key});

  @override
  State<SecondOTP> createState() => _SecondOTPState();
}

class _SecondOTPState extends State<SecondOTP> {
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController phonecontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController OPTcontroller = TextEditingController();
  bool _isverfiy = false;
  Widgets _widgets = Widgets();

  Widget _buildsendCode() {
    return BlocListener<EmailAuthCubit, EmailAuthState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, EmailAuthState state) {
        if (state is SendCodeLoding) {
          _widgets.buildCircularProgressIndicatorDialog(context);
        }
        if (state is Loginfails) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(state.message!),
            ),
          );
        }    if (state is CodeSend) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(state.message!),
            ),
          );
          setState(() {
            _isverfiy = true;
          });
        }
        if (state is SignupSuccess) {
          print(state.name);
          Navigator.maybePop(context);
          Navigator.of(context, rootNavigator: true)
              .pushReplacementNamed(nav, arguments: state.name);
        }
      },
      child: Container(),
    );
  }

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
              _buildsendCode(),
              _widgets.Logo(context),
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
                          child: Center(
                            child: Column(
                              children: [
                                  _widgets.TextFiledLogin(
                                      'OTP Code',
                                      OPTcontroller,
                                      6,
                                      'Enter 6 digits in the What\'sApp SMS ',
                                      context),
                                if (_isverfiy)
                                  _widgets.TextFiledLogin(
                                      'Password',
                                      passwordcontroller,
                                      8,
                                      'Please enter more than 8 characters',
                                      context),
                              ],
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    FadeInUp(
                        duration: Duration(milliseconds: 1900),
                        child: _widgets.AppButton(() {
                          setState(() {});
        
                
                            print('=============seconf');
                            context.read<EmailAuthCubit>().verificationCode(
                                phonecontroller.text,OPTcontroller.text);    

                          if (_isverfiy) {
                            context.read<EmailAuthCubit>().signup(
                                namecontroller.text,
                                phonecontroller.text,
                                passwordcontroller.text);
                          }
                        }, 'Sign Up' )),
                    SizedBox(
                      height: 30,
                    ),
                    FadeInUp(
                        duration: Duration(milliseconds: 2000),
                        child: Center(
                            child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, logain);
                                },
                                child: Text(
                                  "Sign In ?",
                                  style: TextStyle(
                                      color: Color.fromRGBO(49, 39, 79, .6),
                                      fontSize: width * 0.04),
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
