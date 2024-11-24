import 'dart:async';

import 'package:anbobtak/besnese_logic/email_auth/email_auth_cubit.dart';
import 'package:anbobtak/besnese_logic/get_method/get_method_state.dart';
import 'package:anbobtak/web_servese/model/cart.dart';
import 'package:anbobtak/web_servese/model/me.dart';
import 'package:anbobtak/web_servese/model/myOrder.dart';
import 'package:anbobtak/web_servese/model/product.dart';
import 'package:anbobtak/web_servese/model/regions.dart';
import 'package:anbobtak/web_servese/reproserty/myRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../web_servese/model/username.dart';

class GetMethodCubit extends Cubit<GetMethodState> {
  final MyRepo myRepo;
  List<User>? myallUsers;
  EmailAuthCubit emailAuthCubit;
  GetMethodCubit(this.myRepo, this.emailAuthCubit) : super(GetMethodInitial());
  Future<FutureOr<void>> GetProduct() async {
    try {
      emit(LodingState());
      List<Datum> products = await myRepo.getProduct('v1/products/');

      print('Products fetched: $products');

      emit(GetProducts(posts: products));

      print("======products / Product======$products");
    } catch (e) {
      print('========cubits=======${e.toString()}');
      // Add additional error handling here if necessary
    }
  }

  Future<FutureOr<void>> GetCart() async {
    try {
      emit(LodingState());
      List<Item> posts = await myRepo.GetCart('v1/cart/');
      emit(GetCarts(posts: posts));
      print("======Carts======$posts");
    } catch (e) {
      print('========cubits/ carts=======${e.toString()}');
    }
  }

  Future<FutureOr<void>> GetRegions() async {
    try {
      emit(LodingState());
      List<Region> posts = await myRepo.GetRegions('v1/address/regions');
      emit(GetRegion(regions: posts));
      print("======Regions======$posts");
    } catch (e) {
      emit(Fail(e.toString()));
      print('========cubits/ Rigions=======${e.toString()}');
    }
  }

  Future<FutureOr<void>> GetMe() async {
    try {
      emit(LodingState());
      Me posts = await myRepo.GetMe('v1/user/me');
      emit(GetMee(me: posts));
      print("======me======$posts");
    } catch (e) {
      emit(Fail(e.toString()));
      print('========cubits/ me=======${e.toString()}');
    }
  }

    Future<FutureOr<void>> GetOrder() async {
    try {
      emit(LodingState());
      List<MyOrder> posts = await myRepo.GetOrder('v1/orders');
      emit(GetOrders(order: posts));
      print("======me======$posts");
    } catch (e) {
      emit(Fail(e.toString()));
      print('========cubits/ order=======${e.toString()}');
    }
  }
}
