import 'dart:developer';

import 'package:anbobtak/costanse/strings.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    } catch (e) {
      print("======dio error=======${e.toString()}");
      return [];
    }
  }

  Future<List<dynamic>> LoginDio(String end, Object data) async {
    try {
      // Perform POST request with headers
      final response = await dio.post(
        baseUrl + end,
        data: data,
      );

      print('======== $response');

      // Return the response data wrapped in a List
      return [response.data];
    } catch (e) {
      print("====== dio error ======= ${e.toString()}");
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
    } catch (e) {
      print("====== dio error ======= ${e.toString()}");
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
    } catch (e) {
      print("====== dio error ======= ${e.toString()}");
      return [];
    }
  }
}
