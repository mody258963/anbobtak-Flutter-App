import 'package:anbobtak/besnese_logic/email_auth/email_auth_cubit.dart';
import 'package:anbobtak/costanse/colors.dart';
import 'package:anbobtak/presntation_lyar/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Forgetpassword extends StatefulWidget {
  const Forgetpassword({super.key});

  @override
  State<Forgetpassword> createState() => _ForgetpasswordState();
}

class _ForgetpasswordState extends State<Forgetpassword> {
  Widgets _widgets = Widgets();
  final TextEditingController emailcontroller = TextEditingController();

  Widget _buildSendEmail() {
    return BlocListener<EmailAuthCubit, EmailAuthState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, EmailAuthState state) {
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
                title: Text('Don\'t play with me'),
              );
            },
          );
        } else if (state is EmailSend) {
          Navigator.of(context, rootNavigator: true).pop();
          // Navigator.of(context, rootNavigator: true).pop();
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('${state.message}'),
              );
            },
          );

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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            _buildSendEmail(),
            // Logo
            _widgets.Logo(context),
            // Email Input
            Container(
                width: width * 0.90,
                child: _widgets.TextFieldinApp(
                    emailcontroller,
                    'Email',
                    7,
                    'Very Short Email',
                    'Very Long Email',
                    60,
                    0.05,
                    0.05,
                    TextInputType.emailAddress,
                    context)),
            SizedBox(height: height * 0.01),
            // Instruction Text
            Text(
              'Link send to your Email to reset the password',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: height * 0.03),
            // Sign Up Button
            Container(
                width: width * 0.90,
                child: _widgets.AppButton(() {
                  context
                      .read<EmailAuthCubit>()
                      .forgetpassword(emailcontroller.text);
                }, 'Send Email')),
            SizedBox(height: 20),
            // Go to Sign In Page Text
            GestureDetector(
              onTap: () {
                // Add your sign-in navigation functionality here
              },
              child: RichText(
                text: TextSpan(
                  text: 'Go to Sign In Page ',
                  style: TextStyle(color: Colors.grey),
                  children: [
                    TextSpan(
                      text: 'Sign In',
                      style: TextStyle(
                        color: MyColors.Secondcolor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
