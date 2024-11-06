import 'dart:async';

import 'package:anbobtak/besnese_logic/email_auth/email_auth_cubit.dart';
import 'package:anbobtak/besnese_logic/get_method/get_method_state.dart';
import 'package:anbobtak/web_servese/model/cart.dart';
import 'package:anbobtak/web_servese/model/product.dart';
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
      List<Datum> posts = await myRepo.getProduct('v1/products/');
      emit(GetProducts(posts: posts));
      print("======products======$posts");
    } catch (e) {
      print('========cubits=======${e.toString()}');
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

}
	