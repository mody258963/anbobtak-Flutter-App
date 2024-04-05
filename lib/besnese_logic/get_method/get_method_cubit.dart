import 'dart:async';


import 'package:anbobtak/besnese_logic/email_auth/email_auth_cubit.dart';
import 'package:anbobtak/besnese_logic/get_method/get_method_state.dart';
import 'package:anbobtak/web_servese/reproserty/myRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../web_servese/model/username.dart';

class GetMethodCubit extends Cubit<GetMethodState> {
  final MyRepo myRepo;
  List<User>? myallUsers;
  EmailAuthCubit emailAuthCubit;
  GetMethodCubit(this.myRepo, this.emailAuthCubit) : super(GetMethodInitial());

  Future<FutureOr<void>> emitGetAllUSers() async {
    try {
      emit(LodingState());
      List<User> posts = await myRepo.getAllUsers('all-user');
      emit(AllItemsState(posts: posts));
    } catch (e) {
      print('========cubits=======${e.toString()}');
    }
  }
}
// emit(state.copyWith(isLoading: true));
	