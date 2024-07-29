import 'dart:async';

import 'package:anbobtak/web_servese/model/auth.dart';
import 'package:anbobtak/web_servese/model/foget.dart';
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
      List<Auth> result =
          await myRepo.login('login', {'email': email, 'password': password});
      print('=====cubit====$result');
      emit(LoginSuccess());
    } catch (e) {
      emit(Loginfails(e.toString()));
      print('==email cubit===${e.toString()}');
    }
  }

  Future<FutureOr<void>> sendVerificationCode(String phone) async {
    emit(SendCodeLoding());
    try {
      List<Forget> result = await myRepo.sendVerificationCode(
          'send-verification-code', {'phone_number': phone});
      emit(VerificationCodeSend(result.first.message));
    } catch (e) {
      emit(Loginfails(e.toString()));
    }
  }

  Future<FutureOr<void>> VerificationCode(String phone, String code) async {
    emit(VerifingCodeLoading());
    try {
      print('============${[phone,code]}');
      List<Forget> result = await myRepo.sendCode(
          'verify-code', {'phone_number': phone, 'verification_code': code});
      emit(CodeSend(result.first.message));
      print(result.first.message);
    } catch (e) {
      emit(Loginfails(e.toString()));
    }
  }

  Future<FutureOr<void>> signup(
      String name, String phone, String password) async {
    emit(SignUpLoading());
    try {
      List<Auth> result = await myRepo.SignUpUser('register', {
        'name': name,
        'phone': phone,
        'password': password,
      });

      print('=====email_cubit====${result.first.user?.name}');
      emit(SignupSuccess(result.first.user?.name));
    } catch (e) {
      emit(Loginfails(e.toString()));
      print('==email cubit===${e.toString()}');
    }
  }

  Future<FutureOr<void>> forgetpassword(String email) async {
    emit(LoginLoading());
    try {
      List<Forget> result = await myRepo.ForgetEmail('reset', {
        'email': email,
      });

      emit(EmailSend(result.first.message));
    } catch (e) {
      emit(Loginfails(e.toString()));
      print('==email cubit===${e.toString()}');
    }
  }
}
