import 'dart:js';

import 'package:education/authentication/bloc/authentication_bloc.dart';
import 'package:education/screens/splash_screen.dart';
import 'package:education/simple_bloc_delegate.dart';
import 'package:education/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'home/home_screen.dart';
import 'localization/localizations.dart';
import 'login/login_screen.dart';
import 'settinguser/setting_user_page.dart';
 
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final UserRepository userRepository = UserRepository();
  runApp(
    BlocProvider(
      create: (context) => AuthenticationBloc(userRepository: userRepository)..add(AppStarted()),
      child: MyApp(userRepository: userRepository,),
    )
  );
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository;

  const MyApp({Key key, @required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ""),
        Locale("ru", ""),
        Locale('fr', ''),
      ],
      onGenerateTitle: (BuildContext context) =>
          AppLocalizations.of(context).title,
      theme: ThemeData.dark(),
      home: MyHomePage(
        userRepository: userRepository,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final UserRepository userRepository;
  MyHomePage({Key key, @required this.userRepository}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Unauthenticated) {
            return LoginScreen(userRepository: widget.userRepository);
          }
          if (state is Authenticated) {
            return HomeScreen(user: state.user,);
            //return HomeScreen(name: state.displayName, uid: state.uid,);
          }
          if(state is SettingUser){
            return SettingUserPage(userRepository: widget.userRepository, authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),);
          }
          return SplashScreen();
        },
      );
  }
}