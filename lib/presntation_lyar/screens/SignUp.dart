import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:anbobtak/besnese_logic/email_auth/email_auth_cubit.dart';
import 'package:anbobtak/costanse/colors.dart';
import 'package:anbobtak/costanse/pages.dart';
import 'package:anbobtak/presntation_lyar/widgets/widgets.dart';
import 'package:animate_do/animate_do.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

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
  final TextEditingController OPTcontroller = TextEditingController();
  bool _isverfiy = false;
  bool _isResendEnabled = true;
  int _start = 30;
  Timer? _timer;
  Widgets _widgets = Widgets();

  void _startTimer() {
    _start = 30;
    _isResendEnabled = false;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_start > 0) {
          _start--;
        } else {
          _isResendEnabled = true;
          timer.cancel();
        }
      });
    });
  }

  void _showOTPDialog(BuildContext rootContext) {
  final phoneNumber = '+2${phonecontroller.text}';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text("Enter OTP"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            OtpTextField(
              fieldWidth: 36.0,
              numberOfFields: 6,
              borderColor: Color(0xFF512DA8),
              showFieldAsBox: true,
              onCodeChanged: (String code) {
                // Handle code changes
              },
              onSubmit: (String verificationCode) {
                OPTcontroller.text = verificationCode;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              rootContext
                  .read<EmailAuthCubit>()
                  .verificationCode(phoneNumber, OPTcontroller.text);
              Navigator.of(context).pop();
            },
            child: Text("Confirm"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }

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
        }
        if (state is VerificationCodeSend) {
          _startTimer();
          _showOTPDialog(context);
        }
        if (state is CodeSend) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(state.message!),
            ),
          );
          setState(() {
            //_isSend = false;
            _isverfiy = true;
          });
        }
        if (state is SignupSuccess) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(state.name!),
            ),
          );
          Navigator.of(context, rootNavigator: true)
              .pushReplacementNamed(nav, arguments: state.name);
        }
      },
      child: Container(),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 852));
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
                padding: EdgeInsets.symmetric(horizontal: 40.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    FadeInUp(
                        duration: Duration(milliseconds: 1700),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.sp),
                              color: Colors.white,
                              border: Border.all(
                                  color: Color.fromRGBO(196, 135, 198, .3)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.lightBlue,
                                  blurRadius: 20.sp,
                                  offset: Offset(0, 10),
                                )
                              ]),
                          child: Center(
                            child: Column(
                              children: [
                                _widgets.TextFiledLogin('Name', namecontroller,
                                    7, 'Name is very short', context),
                                _widgets.NumberTextField(phonecontroller),
                                if (_isverfiy)
                                  FadeInDown(
                                    child: _widgets.TextFiledLogin(
                                        'Password',
                                        passwordcontroller,
                                        8,
                                        'Please enter more than 8 characters',
                                        context),
                                  ),
                                if (_isverfiy)
                                  FadeInDown(
                                    child: _widgets.TextFiledLogin(
                                        'Confirom Password',
                                        cpasswordcontroller,
                                        8,
                                        'Please enter more than 8 characters',
                                        context),
                                  ),
                              ],
                            ),
                          ),
                        )),
                    SizedBox(
                      height: _isResendEnabled ? 20.h : 1.h,
                    ),
                    if (!_isResendEnabled && !_isverfiy)
                      Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, forgot);
                              },
                              child: Text(
                                'Resend code after $_start',
                                style: TextStyle(color: Colors.grey),
                              ))),
                    SizedBox(
                      height: _isResendEnabled ? 10 : 1,
                    ),
                    FadeInUp(
                        duration: Duration(milliseconds: 1900),
                        child: _widgets.AppButton(() {
                          final phoneNumber = '+2${phonecontroller.text}';
                          print('phone $phoneNumber');
                          if (!_isverfiy) {
                            context
                                .read<EmailAuthCubit>()
                                .sendVerificationCode(phoneNumber);
                          }
                          if (_isverfiy) {
                            context.read<EmailAuthCubit>().signup(
                                namecontroller.text,
                                phonecontroller.text,
                                passwordcontroller.text,
                                cpasswordcontroller.text);
                          }
                        }, _isverfiy ? 'Sign Up' : 'Verfiy ')),
                    SizedBox(
                      height: 10.h,
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
                                      fontSize: 15.sp),
                                )))),
                    SizedBox(
                      height: 10,
                    ),
                    if (!_isverfiy)
                      FadeInUp(
                          duration: Duration(milliseconds: 2100),
                          child:
                              _widgets.ThiredParty(FontAwesomeIcons.google, () {
                            context.read<EmailAuthCubit>().googleSignIn();
                          }, 'Google')),
                    if (!_isverfiy)
                      SizedBox(
                        height: 20,
                      ),
                    if (!_isverfiy)
                      FadeInUp(
                          duration: Duration(milliseconds: 2100),
                          child: _widgets.ThiredParty(
                              FontAwesomeIcons.facebook, () {}, 'Facebook')),
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
