

import 'package:education/authentication/bloc/authentication_bloc.dart';
import 'package:education/widgets/button/bloc/button_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../user_repository.dart';
import 'bloc/login_bloc.dart';
import 'login_form.dart';

class LoginScreen extends StatelessWidget {
  final UserRepository userRepository;
  const LoginScreen({Key key, @required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(userRepository: userRepository, authenticationBloc: BlocProvider.of<AuthenticationBloc>(context)),
        child: BlocProvider<ButtonBloc>(
          create: (context) => ButtonBloc(),
          child: SingleChildScrollView(child: LoginForm(userRepository: userRepository)),
        )
      ),
    );
  }
}