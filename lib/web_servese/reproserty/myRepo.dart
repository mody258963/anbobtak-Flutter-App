import 'dart:convert';

import 'package:anbobtak/web_servese/dio/web_serv.dart';
import 'package:anbobtak/web_servese/model/address.dart';
import 'package:anbobtak/web_servese/model/auth.dart';
import 'package:anbobtak/web_servese/model/item.dart';
import 'package:anbobtak/web_servese/model/product.dart';
import 'package:anbobtak/web_servese/model/username.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyRepo {
  final NameWebServise nameWebService;

  MyRepo(this.nameWebService);

  Future<List<Auth>> getAllUsers(String end) async {
    final names = await nameWebService.get(end);
    final userList = names.map((names) => Auth.fromJson(names)).toList();
    return userList..shuffle();
  }

  Future<List<Product>> getProduct(String end) async {
    final names = await nameWebService.get(end);
    final userList = names.map((names) => Product.fromJson(names)).toList();
    print("=====Product====#$userList");
    return userList..shuffle();
  }

  Future<List<Item>> getItemB(String end, Object data) async {
    final names = await nameWebService.post(
      end,
      data,
    );
    final userList = names.map((names) => Item.fromJson(names)).toList();
    print("=====Item====#${userList..shuffle()}");
    return userList..shuffle();
  }

  Future<List<Item>> getItem(String end, Object data) async {
    final names = await nameWebService.post(end, data);
    final userList = names.map((names) => Item.fromJson(names)).toList();
    print("=====Item====#${userList..shuffle()}");
    return userList..shuffle();
  }

  Future<List<Address>> addLatLong(String end, Object data) async {
    final names = await nameWebService.post(end, data);
    final userList = names.map((names) => Address.fromJson(names)).toList();
    print("=====Address====#${userList..shuffle()}");
    return userList..shuffle();
  }

  Future<List<Item>> getItemM(String end, Object data) async {
    final names = await nameWebService.post(
      end,
      data,
    );
    final userList = names.map((names) => Item.fromJson(names)).toList();
    print("=====Item====#${userList..shuffle()}");
    return userList..shuffle();
  }

  Future<List<Auth>> login(String end, Object data) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final result = await nameWebService.LoginDio(end, data);
      if (result.isNotEmpty) {
        final token = result.map((result) => Auth.fromJson(result)).toList();
        final user = result.map((result) => Auth.fromJson(result)).toList();
        prefs.setString('token', token.first.token!);
        prefs.setInt('user_id', user.first.user!.id!);
        print(user.first.user!.id!);
        return user..shuffle();
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
        final token = result.map((result) => Auth.fromJson(result)).toList();
        final user = result.map((result) => Auth.fromJson(result)).toList();
        prefs.setString('token', token.first.token!);
        prefs.setInt('user_id', user.first.user!.id!);
        prefs.setString('name', user.first.user!.name!);
        print(user.first.user!.id!);
        return user..shuffle();
      } else {
        throw Exception("Invalid response format: Empty or non-list response");
      }
    } catch (e) {
      print("Error during login: ${e.toString()}");
      throw Exception("Failed to login. Please try again.");
    }
  }
}
