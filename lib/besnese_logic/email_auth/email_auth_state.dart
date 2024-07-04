part of 'email_auth_cubit.dart';

@immutable
abstract class EmailAuthState {}

class EmailAuthInitial extends EmailAuthState {}

class LoginLoading extends EmailAuthState{}

class LoginSuccess extends EmailAuthState {

}
class SignupTeacherSuccess extends EmailAuthState {


}


class Loginfails extends EmailAuthState{}