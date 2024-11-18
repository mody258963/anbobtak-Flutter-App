
import 'package:anbobtak/web_servese/model/address.dart';
import 'package:anbobtak/web_servese/model/cart.dart';
import 'package:anbobtak/web_servese/model/me.dart';
import 'package:anbobtak/web_servese/model/product.dart';
import 'package:anbobtak/web_servese/model/regions.dart';
import 'package:flutter/widgets.dart';


import '../../web_servese/model/username.dart';

@immutable
sealed class GetMethodStateV1 {}

class GetMethodInitialV1 extends GetMethodStateV1 {}

class LodingState extends GetMethodStateV1{}




class GetAddres extends GetMethodStateV1 {
 final List<Datas>  posts;

  GetAddres({required this.posts});


}
class GetCartsV1 extends GetMethodStateV1 {
 final List posts;

  GetCartsV1({required this.posts});


}



class Fail extends GetMethodStateV1{
  final String  message ;

  Fail(this.message);

}