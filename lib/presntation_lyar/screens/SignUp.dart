import 'dart:io';

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

// class OTPScreen extends StatefulWidget {
//   const OTPScreen({super.key});

//   @override
//   State<OTPScreen> createState() => _OTPScreenState();
// }

// class _OTPScreenState extends State<OTPScreen> {
//   final TextEditingController namecontroller = TextEditingController();
//   final TextEditingController phonecontroller = TextEditingController();
//   final TextEditingController passwordcontroller = TextEditingController();
//   final TextEditingController OPTcontroller = TextEditingController();
//   bool _isSend = false;
//   bool _isverfiy = false;
//   Widgets _widgets = Widgets();

//   Widget _buildsendCode() {
//     return BlocListener<EmailAuthCubit, EmailAuthState>(
//       listenWhen: (previous, current) {
//         return previous != current;
//       },
//       listener: (context, EmailAuthState state) {
//         if (state is SendCodeLoding) {
//           _widgets.buildCircularProgressIndicatorDialog(context);
//         }
//         if (state is Loginfails) {
//           showDialog(
//             context: context,
//             builder: (context) => AlertDialog(
//               title: Text(state.message!),
//             ),
//           );
//         }
//         if (state is VerificationCodeSend) {
//           showDialog(
//             context: context,
//             builder: (context) => AlertDialog(
//               title: Text(state.message!),
//             ),
//           );
//           setState(() {
//             _isSend = true;
//           });
//           print(_isSend);
//                     Navigator.of(context, rootNavigator: true)
//               .pushReplacementNamed(signup);
//         }
        
//       },
//       child: Container(),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     return MaterialApp(
//       home: Scaffold(
//         backgroundColor: MyColors.white,
//         body: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               _buildsendCode(),
//               _widgets.Logo(context),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 40),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: <Widget>[
//                     FadeInUp(
//                         duration: Duration(milliseconds: 1700),
//                         child: Container(
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               color: Colors.white,
//                               border: Border.all(
//                                   color: Color.fromRGBO(196, 135, 198, .3)),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.lightBlue,
//                                   blurRadius: 20,
//                                   offset: Offset(0, 10),
//                                 )
//                               ]),
//                           child: Center(
//                             child: Column(
//                               children: [
//                                 _widgets.TextFiledLogin('Name', namecontroller,
//                                     7, 'Name is very short', context),
//                                 _widgets.TextFiledLogin(
//                                     'Phone Number',
//                                     phonecontroller,
//                                     9,
//                                     'Very short email',
//                                     context),
//                                 if (_isSend)
//                                   _widgets.TextFiledLogin(
//                                       'OTP Code',
//                                       OPTcontroller,
//                                       6,
//                                       'Enter 6 digits in the What\'sApp SMS ',
//                                       context),
//                                 if (_isverfiy)
//                                   _widgets.TextFiledLogin(
//                                       'Password',
//                                       passwordcontroller,
//                                       8,
//                                       'Please enter more than 8 characters',
//                                       context),
//                               ],
//                             ),
//                           ),
//                         )),
//                     SizedBox(
//                       height: 15,
//                     ),
//                     SizedBox(
//                       height: 30,
//                     ),
//                     FadeInUp(
//                         duration: Duration(milliseconds: 1900),
//                         child: _widgets.AppButton(() {
//                           setState(() {});
//                           if (!_isSend) {
//                             print('===========first');
//                             context
//                                 .read<EmailAuthCubit>()
//                                 .sendVerificationCode(phonecontroller.text);
//                           }
                         
//                           // if (_isSend) {
//                           //   print('=============seconf');
//                           //   context.read<EmailAuthCubit>().verificationCode(
//                           //       phonecontroller.text,OPTcontroller.text);
//                           // }
//                           // if (_isverfiy) {
//                           //   context.read<EmailAuthCubit>().signup(
//                           //       namecontroller.text,
//                           //       phonecontroller.text,
//                           //       passwordcontroller.text);
//                           // }
//                         }, 'Sign Up')),
//                     SizedBox(
//                       height: 30,
//                     ),
//                     FadeInUp(
//                         duration: Duration(milliseconds: 2000),
//                         child: Center(
//                             child: TextButton(
//                                 onPressed: () {
//                                   Navigator.pushNamed(context, logain);
//                                 },
//                                 child: Text(
//                                   "Sign In ?",
//                                   style: TextStyle(
//                                       color: Color.fromRGBO(49, 39, 79, .6),
//                                       fontSize: width * 0.04),
//                                 )))),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
class OTPScreen extends StatefulWidget {
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final Dio _dio = Dio();

  Future<void> sendVerificationCode(String phoneNumber) async {
    try {
      var response = await _dio.post('http://127.0.0.1:8000/api/send-verification-code', data: {
        'phone_number': phoneNumber,
      });
      // Handle response as needed
      print('Code sent: ${response.data}');
    } catch (e) {
      print('Error sending code: $e');
    }
  }
  Future<void> verifyCode(String phoneNumber, String code) async {

      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      (HttpClient client) {
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return client;
  };
    try {
      // Example of setting headers, if required by your API
      Options options = Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      var response = await _dio.post(
        'http://127.0.0.1:8000/api/verify-code',
        data: {//'phone_number': phoneNumber,
         'verification_code': code.trim()},
        options: options,
      );

      print('Verification successful: ${response.data}');
    } catch (e) {
      if (e is DioError) {
        // Print detailed error information
        print('Error verifying code: ${e.response?.statusCode} ${e.response?.data}');
      } else {
        print('Unexpected error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login with Phone'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                sendVerificationCode(_phoneController.text);
              },
              child: Text('Send Code'),
            ),
            TextField(
              controller: _codeController,
              decoration: InputDecoration(labelText: 'Verification Code'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                verifyCode(_phoneController.text, _codeController.text);
              },
              child: Text('Verify Code'),
            ),
          ],
        ),
      ),
    );
  }
}
