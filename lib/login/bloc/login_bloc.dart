import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education/authentication/bloc/authentication_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

import '../../user_repository.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository userRepository;
  AuthenticationBloc authenticationBloc;
  LoginBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  }) : super(LLoginInitialS());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is CreateAccountButtonPressedE) {
      yield LSingUpInitialS();
    }
    if (event is SignInButtonPressedE) {
      yield LLoginInitialS();
    }
    if (event is LoginWithGoogleButtonPressedE) {
      yield* _mapLoginWithGoogle();
    }
    if (event is LogInE) {
      yield* _mapLogin(event.email, event.password);
    }
    if (event is SingUpE) {
      yield* _mapSingUp(event.email, event.password);
    }
  }

  Stream<LoginState> _mapLoginWithGoogle() async* {
    yield LLoadingS();
    try {
      await userRepository.signInWithGoogle();
      yield LSuccesS();
      //await Future.delayed(Duration(seconds: 10));
      final user = await userRepository.getUser();
      final documnet =
          await Firestore.instance.collection('user').document(user.uid).get();
      final isSetted = documnet.data['IsSetted'] as bool;
      for (var i = 0; i < 10; i++) {
        print('    \n');
      }
      print('user: $user');
      print('document: $documnet');
      print('isSetted: $isSetted');
      for (var i = 0; i < 10; i++) {
        print('    \n');
      }
      if (isSetted) {
        await Future.delayed(Duration(seconds: 1));
        authenticationBloc.add(LoggedIn());
      } else {
        await Future.delayed(Duration(seconds: 1));
        authenticationBloc.add(SingedUp());
      }
    } catch (e) {
      if (e is PlatformException) {
        yield LFailureS();
        await Future.delayed(Duration(seconds: 1));
        yield LLoginInitialS();
      }
      if (e is NoSuchMethodError) {
        yield LSettingS();
        await Future.delayed(Duration(seconds: 10));
        final user = await userRepository.getUser();
        final documnet = await Firestore.instance
            .collection('user')
            .document(user.uid)
            .get();
        final isSetted = documnet.data['IsSetted'] as bool;
        for (var i = 0; i < 10; i++) {
          print('    \n');
        }
        print('user: $user');
        print('document: $documnet');
        print('isSetted: $isSetted');
        for (var i = 0; i < 10; i++) {
          print('    \n');
        }
        if (isSetted) {
          await Future.delayed(Duration(seconds: 1));
          authenticationBloc.add(LoggedIn());
        } else {
          await Future.delayed(Duration(seconds: 1));
          authenticationBloc.add(SingedUp());
        }
      }
      yield LFailureS();
      await Future.delayed(Duration(seconds: 1));
      yield LLoginInitialS();
    }
  }

  Stream<LoginState> _mapLogin(String email, String password) async* {
    yield LLoadingS();
    try {
      await userRepository.signInWithCredentials(email, password);
      yield LSuccesS();
      await Future.delayed(Duration(seconds: 1));
      authenticationBloc.add(LoggedIn());
    } catch (e) {
      yield LFailureS();
      await Future.delayed(Duration(seconds: 1));
      yield LLoginInitialS();
    }
  }

  Stream<LoginState> _mapSingUp(String email, String password) async* {
    yield LLoadingS();
    try {
      await userRepository.signUp(email: email, password: password);
      yield LSuccesS();
      await Future.delayed(Duration(seconds: 1));
      authenticationBloc.add(SingedUp());
    } catch (e) {
      yield LFailureS();
      await Future.delayed(Duration(seconds: 1));
      yield LLoginInitialS();
    }
  }
}
