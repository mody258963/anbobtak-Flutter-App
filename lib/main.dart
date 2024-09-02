import 'package:anbobtak/costanse/pages.dart';
import 'package:anbobtak/presntation_lyar/widgets/app_router.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

String? initialRoute;
String? ids;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  Future<bool> checkToken() async {
    final dio = Dio();
    try {
      final token = prefs.getString('token');
      print("===token==$token");
      if (token == null) {
        return false;
      } else {
        Map<String, dynamic> headers = {
          'Authorization':
              'Bearer $token', // Assuming token is prefixed with 'Bearer '
          'Content-Type': 'application/json', // Adjust content type as needed
        };

        final response = await dio.get(
          'http://127.0.0.1:8000/api/v1/user/me',
          options: Options(
            headers: headers,
          ),
        );
        if (response.statusCode == 200) {
          //final data = response.data;
          return true;
        } else {
          print('fuck');
          return false;
        }
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  bool tokenValid = await checkToken();

  if (tokenValid) {
    initialRoute = nav; //nav
  } else {
    initialRoute = logain;
    await prefs.clear();
  }

  runApp(MyApp(
    appRouter: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRouter});

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute,
      initialRoute: initialRoute,
    );
  }
}
