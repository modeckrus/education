part of 'login_bloc.dart';


abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object> get props => null;
}

class CreateAccountButtonPressedE extends LoginEvent {}

class SignInButtonPressedE extends LoginEvent {}

class LoginWithGoogleButtonPressedE extends LoginEvent{}

class LogInE extends LoginEvent {
  final String email;
  final String password;
  LogInE({ @required this.email, @required this.password});
  @override
  List<Object> get props => [email, password];
  @override
  String toString() {
    return 'LogIn event { $email, $password }';
  }
}
class SingUpE extends LoginEvent {
  final String email;
  final String password;
  SingUpE({ @required this.email, @required this.password});
  @override
  List<Object> get props => [email, password];
  @override
  String toString() {
    return 'SingUp event { $email, $password }';
  }
}
