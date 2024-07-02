
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
 final List<dynamic>  posts;

  GetProducts({required this.posts});


}
class Coursefails extends GetMethodState{
  final String  message ;

  Coursefails(this.message);

}