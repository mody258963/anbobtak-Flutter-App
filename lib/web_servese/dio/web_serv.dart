import 'dart:io';
import 'package:anbobtak/costanse/strings.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';

class NameWebServise {
  final dio = Dio();

  Future<List<dynamic>> get(String end) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      print(prefs.getString('token'));
      Map<String, dynamic> headers = {
        'Authorization':
            'Bearer ${prefs.getString('token')}', // Assuming token is prefixed with 'Bearer '
        'Content-Type': 'application/json', // Adjust content type as needed
      };

      final response = await dio.get(
        baseUrl + end,
        options: Options(
          headers: headers,
        ),
      );

      //print([response.data]);
      return response.data['data'];
    } on DioException catch (e) {
      if (e.response != null) {
        // If there's a response from the server
        print('Error response: ${e.response?.data}');
        print('Status code: ${e.response?.statusCode}');
        // Handle the error based on the response status
      } else {
        // If there’s no response (like connection issues)
        print('Error: ${e.message}');
      }
      return [];
    }
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'profile',
    ],
  );

  Future<List<dynamic>> googleIn(String end) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final String idToken = googleAuth.idToken!;

        // Debug: Check the idToken
        print("Google ID Token: $idToken");

        final response = await dio.post(
          baseUrl + end,
          data: {'token': idToken},
          options: Options(
            headers: {'Content-Type': 'application/json'},
            validateStatus: (status) {
              // Let Dio handle the response, including 401
              return status != null && status < 500;
            },
          ),
        );

        // Debug: Check response details
        print("Response Status: ${response.statusCode}");
        print("Response Data: ${response.data}");

        return [response.data];
      } else {
        print("Google sign-in was canceled or failed.");
        return [];
      }
    } catch (e) {
      // Debug: Detailed error output
      print("======dio error=======${e.toString()}");
      return [];
    }
  }

  Future<List<dynamic>> LoginDio(String end, Object data) async {
    try {
      final response = await dio.post(
        baseUrl + end,
        data: data,
      );

      print('======== $response');

      // Return the response data wrapped in a List
      return [response.data];
    } on DioException catch (e) {
      if (e.response != null) {
        // If there's a response from the server
        print('Error response: ${e.response?.data}');
        print('Status code: ${e.response?.statusCode}');
        // Handle the error based on the response status
      } else {
        // If there’s no response (like connection issues)
        print('Error: ${e.message}');
      }
      return [];
    }
  }

  Future<List<dynamic>> SignUpDio(String end, Object data) async {
    try {
      final response = await dio.post(
        baseUrl + end,
        data: data,
      );

      print('======== $response');

      return [response.data];
    } on DioException catch (e) {
      if (e.response != null) {
        // If there's a response from the server
        print('Error response: ${e.response?.data}');
        print('Status code: ${e.response?.statusCode}');
        // Handle the error based on the response status
      } else {
        // If there’s no response (like connection issues)
        print('Error: ${e.message}');
      }
      return [];
    }
  }

  Future<List<dynamic>> SendVerfication(String end, Object data) async {
    try {
      final response = await dio.post(
        baseUrl + end,
        data: data,
      );

      print('======== $response');

      return [response.data];
    }on DioException catch (e) {
      if (e.response != null) {
        // If there's a response from the server
        print('Error response: ${e.response?.data}');
        print('Status code: ${e.response?.statusCode}');
        // Handle the error based on the response status
      } else {
        // If there’s no response (like connection issues)
        print('Error: ${e.message}');
      }
      return [];
    }
  }

  Future<List<dynamic>> post(String end, Object data) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    try {
      Map<String, dynamic> headers = {
        'Authorization':
            'Bearer $token', // Assuming token is prefixed with 'Bearer '
        'Content-Type': 'application/json', // Adjust content type as needed
      };

      // Perform POST request with headers
      final response = await dio.post(
        baseUrl + end,
        data: data,
        options: Options(
          headers: headers,
        ),
      );

      print('======== $response');

      // Return the response data wrapped in a List
      return [response.data];
    } on DioException catch (e) {
      if (e.response != null) {
        // If there's a response from the server
        print('Error response: ${e.response?.data}');
        print('Status code: ${e.response?.statusCode}');
        // Handle the error based on the response status
      } else {
        // If there’s no response (like connection issues)
        print('Error: ${e.message}');
      }
      return [];
    }
  }
}
