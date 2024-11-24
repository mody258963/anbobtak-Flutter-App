import 'dart:convert';

import 'package:anbobtak/besnese_logic/get_method/get_method_state.dart';
import 'package:anbobtak/web_servese/dio/web_serv.dart';
import 'package:anbobtak/web_servese/model/address.dart';
import 'package:anbobtak/web_servese/model/auth.dart';
import 'package:anbobtak/web_servese/model/cart.dart';
import 'package:anbobtak/web_servese/model/foget.dart';
import 'package:anbobtak/web_servese/model/google.dart';
import 'package:anbobtak/web_servese/model/me.dart';
import 'package:anbobtak/web_servese/model/myOrder.dart';
import 'package:anbobtak/web_servese/model/product.dart';
import 'package:anbobtak/web_servese/model/regions.dart';
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

  Future<List<Region>> GetRegions(String end) async {
    final names = await nameWebService.get(end);
    final userList = names.map((names) => Region.fromJson(names)).toList();
    print("=====Region====#$userList");
    return userList..shuffle();
  }

  Future<Me> GetMe(String end) async {
    // Fetch the response from the web service
    final response = await nameWebService.getTypeMap(end);

    print("=====Raw Response==== #$response");

    // Ensure the response is a valid Map and directly parse it
    if (response is Map<String, dynamic>) {
      // Parse the response using the Me model
      final Me me = Me.fromJson(response);

      // Log the details of the "me" object for debugging
      print("=====User Info==== Name: ${me.name}, Email: ${me.email}");

      return me;
    } else {
      // Handle invalid response format
      print("Error: The response is not a valid Map<String, dynamic>.");
      throw Exception("The response is not a valid Map<String, dynamic>.");
    }
  }



 
  Future<List<OrderData>> GetOrder(String end) async {
    // Fetch the response from the web service
    final response = await nameWebService.getTypeMap(end);

    print("=====Raw Response  Order==== #$response");

    // Ensure the response is a valid Map and directly parse it
 
      // Parse the response using the Me model
      final MyOrder order = MyOrder.fromJson(response);

        final List<OrderData> Orderdata = order.data ;
      // Log the details of the "me" object for debugging
      print("===== Order ==== Name: ${order.data}, Email: ${order.data}");

      return Orderdata..shuffle();
   
  }


  

  Future<List<Item>> GetCart(String end) async {
    final prefs = await SharedPreferences.getInstance();
    final response = await nameWebService.getTypeMap(end);

    print("=====Raw Response====#${response.toString()}");
    // Parse the response assuming it's a Map<String, dynamic> from the JSON structure
    final Carts carts = Carts.fromJson(response);

    // Check if data and items are available before extracting
    final List<Item> cartItems = carts.items;

    print("=====Carts====#${carts.items.first.price}");

    // Optional: Save the first cart's ID in shared preferences if needed

    return cartItems..shuffle(); // Shuffles the items list
  }

  Future<Carts> GetPrice(String end) async {
    final prefs = await SharedPreferences.getInstance();
    final response = await nameWebService.getTypeMap(end);

    print("=====Raw Response====#${response.toString()}");
    // Parse the response assuming it's a Map<String, dynamic> from the JSON structure
    final Carts price = Carts.fromJson(response);

    print("=====price====#${price.total}");

    // Optional: Save the first cart's ID in shared preferences if needed

    return price; // Shuffles the items list
  }

  Future<List<Datas>> GetAddress(String end) async {
    final response = await nameWebService.getTypeMap(end);

    print("=====Raw Response Address====#${response.toString()}");

    try {
      // Check if the response is a Map or a List
      if (response is Map<String, dynamic>) {
        final Address address = Address.fromJson(response);
        return address.data..shuffle();
      } else if (response is List<dynamic>) {
        // If the response is just the data array
        final List<Datas> addresses = response
            .map((x) => Datas.fromJson(x as Map<String, dynamic>))
            .toList();
        return addresses..shuffle();
      } else {
        throw Exception("Unexpected response format");
      }
    } catch (e) {
      print('Error parsing response: $e');
      throw Exception('Failed to parse addresses');
    }
  }

  Future<List<Carts>> deleteProduct(String end, Object data) async {
    final names = await nameWebService.post(
      end,
      data,
    );
    final userList = names.map((names) => Carts.fromJson(names)).toList();
    print("=====Carts====#${userList..shuffle()}");
    return userList..shuffle();
  }


  Future<List<Address>> createOrder(String end, Object data) async {
    final names = await nameWebService.post(end, data);
    final userList = names.map((names) => Address.fromJson(names)).toList();
    print("=====Address====#${userList..shuffle()}");
    return userList..shuffle();
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

  Future<List<Address>> addAddress(String end, Object data) async {
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
