import 'dart:async';
import 'dart:io';

import 'package:anbobtak/web_servese/model/address.dart';
import 'package:anbobtak/web_servese/model/cart.dart';
import 'package:anbobtak/web_servese/model/order.dart';
import 'package:anbobtak/web_servese/model/product.dart';
import 'package:anbobtak/web_servese/reproserty/myRepo.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'uploding_data_state.dart';

class UplodingDataCubit extends Cubit<UplodingDataState> {
  final MyRepo myRepo;
  UplodingDataCubit(this.myRepo) : super(UplodingDataInitial());

  final List<String> UrlPhotos = [];

  // Future<void> uploadImagesAndSaveUrls(File? image, String title, String book,
  //     String description, int category) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final id = prefs.getString('user_id');
  //   print('-==========id======= $id');
  //   emit(Loading());
  //   try {
  //     FormData formData = FormData.fromMap({
  //       'image': await MultipartFile.fromFile(
  //         image!.path,
  //       ),
  //       'title': title,
  //       'book': book,
  //       'description': description,
  //     });
  //     List<dynamic> getfile =
  //         await myRepo.CourseUpload('add-course/$category/$id', formData);

  //     await Future.delayed(const Duration(seconds: 2));
  //     if (getfile.isEmpty) {
  //       return print('=============erorr1=======');
  //     } else {
  //       emit(Uploaded());
  //     }
  //   } catch (error) {
  //     print('===========eroor==============${error.toString()}');
  //     emit(ErrorOccurred(errorMsg: error.toString()));
  //   }
  // }

  Future<void> addItemInCart(quantity, productId) async {
    try {
      List<Carts> Items = await myRepo.addItemCart('v1/cart/add-item', {
        'product_id': productId,
        'quantity': quantity,
      });
      print('====CArt Items=====$Items');
      emit(ItemUploaded(Items: Items));
    } catch (e) {
      emit(ErrorOccurred(errorMsg: e.toString()));
    }
  }

  Future<void> addAddress(
    String building,
    String apt,
    String addAddress,
    String floor,
    String lat,
    String long,
    String street,
    String phone,
  ) async {
    try {
      // Call the repository method to add an address
      final response = await myRepo.addAddress('v1/address', {
        'building_number': building,
        'apartment_number': apt,
        'additional_address': addAddress,
        'floor': floor,
        'lat': lat,
        'long': long,
        'street': street,
        'phone': phone,
      });

      // Assuming `response` contains a list of addresses or a single address with `id`
      if (response.isNotEmpty) {
        final addressId =
            response.first.data.first.id; // Get the ID of the created address
        emit(AddressLatUploaded(
            address: addressId)); // Emit the state with the address ID
      } else {
        emit(ErrorOccurred(errorMsg: "Failed to create address."));
      }
    } catch (e) {
      print('Error adding address: ${e.toString()}');
      emit(ErrorOccurred(errorMsg: e.toString()));
    }
  }

  // Future<void> createOrder( productId) async {
  //   try {
  //     List<Carts> Items = await myRepo.createOrder('v1/cart/remove-item', {
  //       'product_id': productId,
  //       '_method': 'delete'
  //     });
  //     print('====CArt Items=====$Items');
  //     emit(ItemUploaded(Items: Items));
  //   } catch (e) {
  //     emit(ErrorOccurred(errorMsg: e.toString()));
  //   }
  // }

  Future<void> deleteProduct(productId) async {
    try {
      List<Carts> Items = await myRepo.deleteProduct('v1/cart/remove-item',
          {'product_id': productId, '_method': 'delete'});
      print('====CArt Items=====$Items');
      emit(ItemUploaded(Items: Items));
    } catch (e) {
      emit(ErrorOccurred(errorMsg: e.toString()));
    }
  }
Future<void> OrderMake(addressId, type) async {
  try {
    print('OrderMake triggered with type: $type');

    PAYData? order = await myRepo.OrderMake('v1/orders/store', {
      'address_id': addressId,
      'payment_method': type,
    });

    if (order != null) {
      print('Parsed Order: $order');
      print('Payment Method: ${order.paymentMethod}');
      print('Payment URL: ${order.paymentUrl}');

      if (type == 'cash_On_delivery') {
        emit(CashOnDelivery(order: order));
      } else if (order.paymentUrl != null) {
        emit(PayOrder(order: order, paymentUrl: order.paymentUrl!));
      } else {
        emit(ErrorOccurred(errorMsg: 'Payment URL not found.'));
      }
    }
  } catch (e) {
    if (e.toString() == 'Exception: OrderAlreadyCreated') {
      emit(OrderAlreadyCreated(errorMsg: 'Order already created.'));
    } else {
      emit(ErrorOccurred(errorMsg: e.toString()));
    }
  }
}




}
