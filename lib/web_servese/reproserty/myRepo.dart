import 'dart:convert';

import 'package:anbobtak/web_servese/dio/web_serv.dart';
import 'package:anbobtak/web_servese/model/address.dart';
import 'package:anbobtak/web_servese/model/auth.dart';
import 'package:anbobtak/web_servese/model/cart.dart';
import 'package:anbobtak/web_servese/model/foget.dart';
import 'package:anbobtak/web_servese/model/google.dart';
import 'package:anbobtak/web_servese/model/product.dart';
import 'package:anbobtak/web_servese/model/username.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/google.dart';

class MyRepo {
  final NameWebServise nameWebService;

  MyRepo(this.nameWebService);

  Future<List<Auth>> getAllUsers(String end) async {
    final names = await nameWebService.get(end);
    final userList = names.map((names) => Auth.fromJson(names)).toList();
    return userList..shuffle();
  }

  Future<List<Datum>> getProduct(String end) async {
    final names = await nameWebService.get(end);
    final userList = names.map((names) => Datum.fromJson(names)).toList();
    print("=====Product====#$userList");
    return userList..shuffle();
  }


Future<List<Item>> GetCart(String end) async {
  final prefs = await SharedPreferences.getInstance();
  final response = await nameWebService.getTypeMap(end);

  // Parse the response assuming it's a Map<String, dynamic> from the JSON structure
  final Carts carts = Carts.fromJson(response);

  // Check if data and items are available before extracting
  final List<Item> cartItems = carts.data?.items ?? [];

  print("=====cart====#$cartItems");

  // Optional: Save the first cart's ID in shared preferences if needed
  if (carts.data != null) {
    prefs.setInt('cart_id', carts.data!.id!);
  }

  return cartItems..shuffle(); // Shuffles the items list
}


  Future<List<Carts>> addItemCart(String end, Object data) async {
    final names = await nameWebService.post(
      end,
      data,
    );

    final userList = names.map((names) => Carts.fromJson(names)).toList();
    print("=====Carts====#${userList..shuffle()}");
    return userList..shuffle();
  }

 
  Future<List<Address>> addLatLong(String end, Object data) async {
    final names = await nameWebService.post(end, data);
    final userList = names.map((names) => Address.fromJson(names)).toList();
    print("=====Address====#${userList..shuffle()}");
    return userList..shuffle();
  }

  Future<List<Carts>> getCartsM(String end, Object data) async {
    final names = await nameWebService.post(
      end,
      data,
    );
    final userList = names.map((names) => Carts.fromJson(names)).toList();
    print("=====Carts====#${userList..shuffle()}");
    return userList..shuffle();
  }

  Future<List<Auth>> login(String end, Object data) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final result = await nameWebService.LoginDio(end, data);
      if (result.isNotEmpty) {
        final token = result.map((result) => Auth.fromJson(result)).toList();
        final user = result.map((result) => Auth.fromJson(result)).toList();
        prefs.setString('token', token.first.data!.token!);
        print(prefs.getString('token'));
        prefs.setInt('user_id', user.first.data!.user!.id!);
        prefs.setString('name', user.first.data!.user!.name!);
        return user..shuffle();
      } else {
        throw Exception("Invalid response format: Empty or non-list response");
      }
    } catch (e) {
      print("Error during login: ${e.toString()}");
      throw Exception("Failed to login. Please try again.");
    }
  }

  Future<List<Forget>> ForgetEmail(String end, Object data) async {
    final names = await nameWebService.post(end, data);
    final userList = names.map((names) => Forget.fromJson(names)).toList();
    print("=====Carts====#${userList..shuffle()}");
    return userList..shuffle();
  }

  Future<List<Auth>> GoogleSign(String end) async {
    final names = await nameWebService.googleIn(end);
    final userList = names.map((names) => Auth.fromJson(names)).toList();
    print("=====Carts====#${userList..shuffle()}");
    return userList..shuffle();
  }

  Future<List<Forget>> sendVerificationCode(String end, Object data) async {
    final names = await nameWebService.post(end, data);
    final userList = names.map((names) => Forget.fromJson(names)).toList();
    print("=====Carts====#${userList..shuffle()}");
    return userList..shuffle();
  }

  Future<List<Forget>> sendCode(String end, Object data) async {
    final names = await nameWebService.post(end, data);
    final userList = names.map((names) => Forget.fromJson(names)).toList();
    print("=====Carts====#${userList..shuffle()}");
    return userList..shuffle();
  }

  Future<List<Auth>> SignUpUser(String end, Object data) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final result = await nameWebService.SignUpDio(end, data);

      if (result.isNotEmpty) {
        final token = result.map((result) => Auth.fromJson(result)).toList();
        final user = result.map((result) => Auth.fromJson(result)).toList();
        prefs.setString('token', token.first.data!.token!);
        prefs.setInt('user_id', user.first.data!.user!.id!);
        prefs.setString('name', user.first.data!.user!.name!);
        //print(user.first.user!.id!);
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
