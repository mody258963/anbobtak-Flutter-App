
import 'package:anbobtak/web_servese/model/cart.dart';
import 'package:anbobtak/web_servese/model/me.dart';
import 'package:anbobtak/web_servese/model/myOrder.dart';
import 'package:anbobtak/web_servese/model/product.dart';
import 'package:anbobtak/web_servese/model/regions.dart';
import 'package:flutter/widgets.dart';


import '../../web_servese/model/username.dart';

@immutable
sealed class GetMethodState {}

class GetMethodInitial extends GetMethodState {}

class LodingState extends GetMethodState{}

class AllItemsState extends GetMethodState {
 final List<User> posts;

  AllItemsState({required this.posts});


}


class CatogoryState extends GetMethodState {
 final List<dynamic>  posts;

  CatogoryState({required this.posts});


}


class GetOrders extends GetMethodState{
  final List<MyOrder>  order;
  GetOrders({required this.order});
}


class GetProducts extends GetMethodState {
 final List<Datum>  posts;

  GetProducts({required this.posts});


}
class GetCarts extends GetMethodState {
 final List posts;

  GetCarts({required this.posts});


}
class GetCartsandProducts extends GetMethodState {
 final List  cart;
 final List<Datum>  products;

  GetCartsandProducts({required this.cart, required this.products});


}

class GetRegion extends GetMethodState{
  final List<Region> regions;
  GetRegion({required this.regions});
}


class GetMee extends GetMethodState{
  final Me me;
  GetMee({required this.me});
}

class Fail extends GetMethodState{
  final String  message ;

  Fail(this.message);

}