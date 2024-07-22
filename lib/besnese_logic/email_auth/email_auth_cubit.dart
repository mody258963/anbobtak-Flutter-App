import 'dart:async';

import 'package:anbobtak/web_servese/model/auth.dart';
import 'package:anbobtak/web_servese/reproserty/myRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'email_auth_state.dart';

class EmailAuthCubit extends Cubit<EmailAuthState> {
  final MyRepo myRepo;
  EmailAuthCubit(this.myRepo) : super(EmailAuthInitial());

  Future<FutureOr<void>> loginUser(String email, String password) async {
    emit(LoginLoading());

    try {
      List<Auth> result = await myRepo
          .login('users/login', {'email': email, 'password': password});
      print('=====cubit====$result');
      emit(LoginSuccess());
    } catch (e) {
      emit(Loginfails());
      print('==email cubit===${e.toString()}');
    }
  }

  Future<FutureOr<void>> signup(
      String name, String email, String password) async {
    emit(LoginLoading());
    try {
    
      List<Auth> result = await myRepo.SignUpUser('users/register', {
        'name': name,
        'email': email,
        'password': password,
      });

      print('=====email_cubit====${result.first.user?.name}');
      emit(SignupSuccess(result.first.user?.name));
    } catch (e) {
      emit(Loginfails());
      print('==email cubit===${e.toString()}');
    }
  }
}
