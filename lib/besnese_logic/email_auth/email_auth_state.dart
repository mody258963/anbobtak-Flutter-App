part of 'email_auth_cubit.dart';

@immutable
abstract class EmailAuthState {}

class EmailAuthInitial extends EmailAuthState {}

class LoginLoading extends EmailAuthState{}

class LoginSuccess extends EmailAuthState {
    final String? name  ;

  LoginSuccess(this.name );


}

class SendCodeLoding extends EmailAuthState {}

class SignUpLoading extends EmailAuthState {}

class SignupSuccess extends EmailAuthState {

  final String? name  ;

  SignupSuccess(this.name );


}
class EmailSend extends EmailAuthState{
    final String? message;

  EmailSend(this.message);

}

class VerificationCodeSend extends EmailAuthState{
    final String? message;

  VerificationCodeSend(this.message);

}


class CodeSend extends EmailAuthState{
    final String? message;

  CodeSend(this.message);

}

class VerifingCodeLoading extends EmailAuthState{

}

class Loginfails extends EmailAuthState{
      final String? message;

  Loginfails(this.message);
}