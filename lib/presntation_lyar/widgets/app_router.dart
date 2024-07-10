import 'package:anbobtak/besnese_logic/email_auth/email_auth_cubit.dart';
import 'package:anbobtak/costanse/pages.dart';
import 'package:anbobtak/presntation_lyar/screens/HomeScreen.dart';
import 'package:anbobtak/presntation_lyar/screens/NavigationBar.dart';
import 'package:anbobtak/presntation_lyar/screens/OtpScreen.dart';
import 'package:anbobtak/presntation_lyar/screens/ProfileScreen.dart';
import 'package:anbobtak/presntation_lyar/screens/SignUp.dart';
import 'package:anbobtak/presntation_lyar/screens/emailScreen.dart';
import 'package:anbobtak/presntation_lyar/screens/mapsScreen.dart';
import 'package:anbobtak/web_servese/dio/web_serv.dart';
import 'package:anbobtak/web_servese/reproserty/myRepo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../besnese_logic/get_method/get_method_cubit.dart';
import '../../besnese_logic/uploding_data/uploding_data_cubit.dart';

class AppRouter {
  UplodingDataCubit? uplodingDataCubit;
  GetMethodCubit? getMethodCubit;
  EmailAuthCubit? emailAuthCubit;
  AppRouter() {
    MyRepo myRepoInstance = MyRepo(NameWebServise());
    uplodingDataCubit = UplodingDataCubit(myRepoInstance);
    emailAuthCubit = EmailAuthCubit(
      myRepoInstance,
    );
    getMethodCubit = GetMethodCubit(
        myRepoInstance, emailAuthCubit ?? EmailAuthCubit(myRepoInstance));
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
       case logain:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<EmailAuthCubit>.value(
                  value: emailAuthCubit!,
                  child: const SignUp(),
                ));
      case homescreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<GetMethodCubit>.value(
                  value: getMethodCubit!,
                  child: NavigationBars(),
                ));
      case account:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<GetMethodCubit>.value(
                  value: getMethodCubit!,
                  child: ProfileScreen(),
                ));
      case map:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<GetMethodCubit>.value(
                  value: getMethodCubit!,
                  child: MapScreen(),
                ));
           case addresspage:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<EmailAuthCubit>.value(
                  value: emailAuthCubit!,
                  child: EmailScreen(),
                ));
      case emailpage:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<EmailAuthCubit>.value(
                  value: emailAuthCubit!,
                  child: EmailScreen(),
                ));
      case otp:
      final phoneNumber = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => BlocProvider<EmailAuthCubit>.value(
                  value: emailAuthCubit!,
                  child: OTPScreen(phonenumber: phoneNumber),
                ));
            case nav:
              return MaterialPageRoute(
             builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<GetMethodCubit>.value(value: getMethodCubit!),
              BlocProvider<UplodingDataCubit>.value(value: uplodingDataCubit!)
            ],
            child: const NavigationBars(),
          ),
        );

  case realhomescreen:
              return MaterialPageRoute(
             builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<GetMethodCubit>.value(value: getMethodCubit!),
              BlocProvider<UplodingDataCubit>.value(value: uplodingDataCubit!)
            ],
            child: const HomeScreen(),
          ),
        );
    }
    return null;
  }
}
