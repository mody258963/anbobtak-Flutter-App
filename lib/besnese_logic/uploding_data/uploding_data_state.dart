import 'dart:io';

import 'package:anbobtak/web_servese/model/address.dart';
import 'package:anbobtak/web_servese/model/item.dart';

sealed class UplodingDataState {}

final class UplodingDataInitial extends UplodingDataState {}

class Loading extends UplodingDataState {}

class ErrorOccurred extends UplodingDataState {
  final String errorMsg;

  ErrorOccurred({required this.errorMsg});
}


class ItemUploaded extends UplodingDataState {
 final List<Item>  Items;

  ItemUploaded({required this.Items});

}
class AddressLatUploaded extends UplodingDataState {
 final List<Address>  address;

  AddressLatUploaded({required this.address});

}

class PhoneOTPVerified extends UplodingDataState {}
