part of 'email_auth_cubit.dart';

@immutable
abstract class EmailAuthState {}

class EmailAuthInitial extends EmailAuthState {}

class LoginLoading extends EmailAuthState{}

class LoginSuccess extends EmailAuthState {

}
class SignupSuccess extends EmailAuthState {

  final String? name  ;

  SignupSuccess(this.name );


}


class Loginfails extends EmailAuthState{}