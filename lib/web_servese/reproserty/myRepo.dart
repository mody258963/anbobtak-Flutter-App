import 'dart:convert';

import 'package:anbobtak/web_servese/dio/web_serv.dart';
import 'package:anbobtak/web_servese/model/auth.dart';
import 'package:anbobtak/web_servese/model/product.dart';
import 'package:anbobtak/web_servese/model/username.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyRepo {
  final NameWebServise nameWebService;

  MyRepo(this.nameWebService);

  Future<List<User>> getAllUsers(String end) async {
    final names = await nameWebService.get(end);
    final userList = names.map((names) => User.fromJson(names)).toList();
    return userList..shuffle();
  }

  Future<List<Product>> getProduct(String end) async {
    final names = await nameWebService.get(end);
    final userList = names.map((names) => Product.fromJson(names)).toList();
    print("=========#$userList");
    return userList..shuffle();
  }

  Future<List<Auth>> login(String end, Object data) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final result = await nameWebService.LoginDio(end, data);
      if (result.isNotEmpty) {
        final userList = result.map((result) => Auth.fromJson(result)).toList();
        prefs.setString('token', userList.first.accessToken!);
        prefs.setString('user_id', userList.first.userId.toString());
        print(userList.first.userId.toString());
        return userList..shuffle();
      } else {
        throw Exception("Invalid response format: Empty or non-list response");
      }
    } catch (e) {
      print("Error during login: ${e.toString()}");
      throw Exception("Failed to login. Please try again.");
    }
  }

  Future<List<Auth>> SignUpUser(String end, Object data) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final result = await nameWebService.SignUpDio(end, data);

      if (result.isNotEmpty) {
        final userList = result.map((result) => Auth.fromJson(result)).toList();
        prefs.setString('token', userList.first.accessToken!);
        prefs.setString('user_id', userList.first.userId.toString());
        print(userList.first.userId.toString());
        return userList..shuffle();
      } else {
        throw Exception("Invalid response format: Empty or non-list response");
      }
    } catch (e) {
      print("Error during login: ${e.toString()}");
      throw Exception("Failed to login. Please try again.");
    }
  }
}
