
import 'package:anbobtak/web_servese/model/cart.dart';
import 'package:anbobtak/web_servese/model/product.dart';
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
class Coursefails extends GetMethodState{
  final String  message ;

  Coursefails(this.message);

}