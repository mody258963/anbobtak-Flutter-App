import 'dart:io';

import 'package:anbobtak/web_servese/model/address.dart';
import 'package:anbobtak/web_servese/model/cart.dart';
import 'package:anbobtak/web_servese/model/item.dart';
import 'package:anbobtak/web_servese/model/order.dart';

sealed class UplodingDataState {}

final class UplodingDataInitial extends UplodingDataState {}

class Loading extends UplodingDataState {}

class ErrorOccurred extends UplodingDataState {
  final String errorMsg;

  ErrorOccurred({required this.errorMsg});
}


class ItemUploaded extends UplodingDataState {
 final List<Carts>  Items;

  ItemUploaded({required this.Items});

}

class PayOrder extends UplodingDataState {
 final PAYData  order;
 
 final String paymentUrl;

  PayOrder({required this.order, required this.paymentUrl});

}

class CashOnDelivery extends UplodingDataState {
  final PAYData order;

  CashOnDelivery({required this.order});
}

class OrderAlreadyCreated extends UplodingDataState {
  final String errorMsg;
  OrderAlreadyCreated({required this.errorMsg});
}


class AddressLatUploaded extends UplodingDataState {
 final int? address;

  AddressLatUploaded({required this.address});

}

class GetCarts extends UplodingDataState {
 final List posts;

  GetCarts({required this.posts});


}

class PhoneOTPVerified extends UplodingDataState {}
