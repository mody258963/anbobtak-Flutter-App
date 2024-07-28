import 'package:anbobtak/besnese_logic/email_auth/email_auth_cubit.dart';
import 'package:anbobtak/costanse/colors.dart';
import 'package:anbobtak/costanse/pages.dart';
import 'package:anbobtak/presntation_lyar/widgets/widgets.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController phonecontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController cpasswordcontroller = TextEditingController();
  bool _isSend = false;
  bool _isverfiy = false;
  Widgets _widgets = Widgets();

  Widget _buildsendCode() {
    return BlocListener<EmailAuthCubit, EmailAuthState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, EmailAuthState state) {
        if (state is LoginLoading) {
          //_widgets.buildCircularProgressIndicatorDialog(context);
        }
        if (state is Loginfails) {
          AlertDialog(
            title: Text(state.message!),
          );
        }
        if (state is VerificationCodeSend) {
          AlertDialog(
            title: Text(state.message!),
          );
          _isSend = true;
          print(_isSend);
         // Navigator.pop(context);
        }
        if (state is CodeSend) {
          AlertDialog(
            title: Text(state.message!),
          );
          _isverfiy = true;
          Navigator.maybePop(context);
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
                                _widgets.TextFiledLogin('Name', namecontroller,
                                    7, 'Name is very short', context),
                                _widgets.TextFiledLogin(
                                    'Phone Number',
                                    phonecontroller,
                                    9,
                                    'Very short email',
                                    context),
                                if (_isSend)
                                  _widgets.TextFiledLogin(
                                      'OTP Code',
                                      passwordcontroller,
                                      6,
                                      'Enter 6 digits in the What\'sApp SMS ',
                                      context),
                                if (_isverfiy)
                                  _widgets.TextFiledLogin(
                                      'Password',
                                      cpasswordcontroller,
                                      8,
                                      'Please enter more then 8 charactor',
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
                          context
                              .read<EmailAuthCubit>()
                              .sendVerificationCode(phonecontroller.text);
                          setState(() {});
                          if (_isverfiy) {
                            context.read<EmailAuthCubit>().signup(
                                namecontroller.text,
                                phonecontroller.text,
                                passwordcontroller.text);
                          }
                        }, _isverfiy ? 'Sign Up' : 'Verify')),
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
