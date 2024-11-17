import 'dart:async';

import 'package:anbobtak/besnese_logic/email_auth/email_auth_cubit.dart';
import 'package:anbobtak/besnese_logic/get_method%20v1/get_method_state.dart';
import 'package:anbobtak/web_servese/model/address.dart';
import 'package:anbobtak/web_servese/model/cart.dart';
import 'package:anbobtak/web_servese/model/me.dart';
import 'package:anbobtak/web_servese/model/product.dart';
import 'package:anbobtak/web_servese/model/regions.dart';
import 'package:anbobtak/web_servese/reproserty/myRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../web_servese/model/username.dart';

class GetMethodCubitV2 extends Cubit<GetMethodStateV1> {
  final MyRepo myRepo;
  List<User>? myallUsers;
  EmailAuthCubit emailAuthCubit;
  GetMethodCubitV2(this.myRepo, this.emailAuthCubit) : super(GetMethodInitialV1());

  
    Future<FutureOr<void>> GetCart() async {   // to do : divide the cubits  
    try {
      emit(LodingState());
      List<Item> posts = await myRepo.GetCart('v1/cart/');
      emit(GetCarts(posts: posts));
      print("======Carts======$posts");
    } catch (e) {
      print('========cubits/ carts=======${e.toString()}');
    }
  }
  //  Future<FutureOr<void>> GetAddressAndLastAdress() async {

      Future<FutureOr<void>> GetAddress() async {   // to do : divide the cubits  
    try {
      emit(LodingState());
      List<Datas> posts = await myRepo.GetAddress('v1/address/');
      emit(GetAddres(posts: posts));
      
      print("======Carts======$posts");
    } catch (e) {
      print('========cubits/ Address=======${e.toString()}');
    }
  }
}
