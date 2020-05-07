part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
    @override
  List<Object> get props => null;
}
///Rules about naming 
///1. First Letter is firstlettor of bloc in Login it's L
///2. Second Name of state
///3. Last is S - abbreviation of State
class LLoginInitialS extends LoginState {
}
class LSingUpInitialS extends LoginState{}

class LFailureS extends LoginState{}

class LLoadingS extends LoginState{}

class LSuccesS extends LoginState{}

class LSettingS extends LoginState{}