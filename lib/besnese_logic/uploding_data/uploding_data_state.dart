import 'dart:io';

import 'package:anbobtak/web_servese/model/item.dart';

sealed class UplodingDataState {}

final class UplodingDataInitial extends UplodingDataState {}

class Loading extends UplodingDataState {}

class ErrorOccurred extends UplodingDataState {
  final String errorMsg;

  ErrorOccurred({required this.errorMsg});
}


class Uploaded extends UplodingDataState {
 final List<Item>  Items;

  Uploaded({required this.Items});

}

class PhoneOTPVerified extends UplodingDataState {}
