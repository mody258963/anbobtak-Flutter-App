import 'dart:io';

import 'package:anbobtak/web_servese/model/address.dart';
import 'package:anbobtak/web_servese/model/item.dart';
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

  Future<void> MakeItemB(quantity) async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('user_id');
    final productId = prefs.getInt('Product');
    try {
      List<Item> Items = await myRepo.getItemB('order/add/b/quntaty', {
        'product_id': productId,
        'quantity' : quantity,
        'user_id': id,
      });
      print('====Items=====$Items');
      emit(ItemUploaded(Items: Items));
    } catch (e) {
      emit(ErrorOccurred(errorMsg: e.toString()));
    }
  }


    Future<void> getItem() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('user_id');
    final productId = prefs.getInt('Product');
    try {
      List<Item> Items = await myRepo.getItem('order/add/a/quntaty', {
        'product_id': productId,
        'user_id': id,
      });

      emit(ItemUploaded(Items: Items));
    } catch (e) {
      emit(ErrorOccurred(errorMsg: e.toString()));
    }
  }


    Future<void> addLatLong(lat, long) async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('user_id');
    try {
      List<Address> address = await myRepo.addLatLong('address/store/lat', {
        'user_id': id,
        'lat': lat,
        'long': long,
      });

      emit(AddressLatUploaded(address: address));
    } catch (e) {
      emit(ErrorOccurred(errorMsg: e.toString()));
    }
  }
}
