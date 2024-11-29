import 'dart:async';
import 'package:anbobtak/besnese_logic/email_auth/email_auth_cubit.dart';
import 'package:anbobtak/web_servese/reproserty/myRepo.dart';


import 'package:anbobtak/web_servese/model/myOrder.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'order_cubit_state.dart';

class OrderCubitCubit extends Cubit<OrderCubitState> {
   final MyRepo myRepo;
     EmailAuthCubit emailAuthCubit;

  OrderCubitCubit(this.myRepo, this.emailAuthCubit) : super(OrderCubitInitial());


    Future<FutureOr<void>> GetOrder() async {
    try {
      emit(LodingState());
      List<OrderData> posts = await myRepo.GetOrder('v1/orders');
      emit(GetOrders(order: posts));
      print("======me======$posts");
    } catch (e) {
      emit(Fail(e.toString()));
      print('========cubits/ order=======${e.toString()}');
    }
  }
  
}
