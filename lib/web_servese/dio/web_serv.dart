import 'dart:developer';

import 'package:anbobtak/costanse/strings.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


class NameWebServise {
  final dio = Dio();

  Future<List<dynamic>> get(String end) async {
    try {
      final response = await dio.get(baseUrl + end);
      // Assuming the list is under a key like 'someKey'
      if (response.data is Map<String, dynamic> &&
          response.data.containsKey('data')) {
        // Explicitly cast the data to List<dynamic>
        return List<dynamic>.from(response.data['data']);
      } else {
        print("Data format is not as expected.");
        return [];
      }
    } catch (e) {
      print("======dio error=======${e.toString()}");
      return [];
    }
  }

  Future<List<dynamic>> post(String end, Object data) async {
    try {
      final response = await dio.post(baseUrl + end,
          data: data,
          );
    

      print('========$response');
      return [response.data];
    } catch (e) {
      print("======dio=======${e.toString()}");
      return [];
    }
  }
}
