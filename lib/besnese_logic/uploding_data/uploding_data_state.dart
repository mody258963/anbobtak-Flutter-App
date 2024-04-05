import 'dart:io';

sealed class UplodingDataState {}

final class UplodingDataInitial extends UplodingDataState {}

class Loading extends UplodingDataState {}

class ErrorOccurred extends UplodingDataState {
  final String errorMsg;

  ErrorOccurred({required this.errorMsg});
}

class GetDataFromUi extends UplodingDataState {
  final File? data;

  GetDataFromUi({required this.data});
}

class Uploaded extends UplodingDataState {}

class PhoneOTPVerified extends UplodingDataState {}
