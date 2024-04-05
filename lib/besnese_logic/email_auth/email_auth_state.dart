part of 'email_auth_cubit.dart';

@immutable
abstract class EmailAuthState {}

class EmailAuthInitial extends EmailAuthState {}

class LoginLoading extends EmailAuthState{}

class LoginSuccess extends EmailAuthState {
  final String userId;

  LoginSuccess({required this.userId});

}
class SignupTeacherSuccess extends EmailAuthState {
  final String userId;

  SignupTeacherSuccess({required this.userId});

}


class Loginfails extends EmailAuthState{}