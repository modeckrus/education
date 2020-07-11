import 'package:education/authentication/bloc/authentication_bloc.dart';
import 'package:education/bloc_observer.dart';
import 'package:education/messaging/messaging_service.dart';
import 'package:education/messaging/web_messaging_service.dart';
import 'package:education/route_generator.dart';
import 'package:education/screens/splash_screen.dart';
import 'package:education/service/lang-codes.dart';
import 'package:education/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';

import 'home/home_screen.dart';
import 'localization/localizations.dart';
import 'login/login_screen.dart';
import 'settinguser/setting_user_page.dart';

const ISWEB = true;
const ISIOS = false;
const ISAND = false;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  final UserRepository userRepository = UserRepository();

  if (ISAND) {
    MessageHandlerService service = MessageHandlerService();
    service.init();
  }

  runApp(BlocProvider(
    create: (context) =>
        AuthenticationBloc(userRepository: userRepository)..add(AppStarted()),
    child: MyApp(
      userRepository: userRepository,
    ),
  ));
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
      supportedLocales: LangCodes.locales,
      onGenerateTitle: (BuildContext context) =>
          AppLocalizations.of(context).title,
      theme: ThemeData.dark(),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        return RouteGenerator.generateRoute(settings, userRepository);
      },
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
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is Unauthenticated) {
          return LoginScreen(userRepository: widget.userRepository);
        }
        if (state is Authenticated) {
          if (ISIOS) {
            MessageHandlerService service = MessageHandlerService();
            service.init();
          }
          if (ISWEB) {
            initWebMessagingHandler();
          }
          return HomeScreen(
            user: state.user,
          );
          //return HomeScreen(name: state.displayName, uid: state.uid,);
        }
        if (state is SettingUser) {
          return SettingUserPage(
            userRepository: widget.userRepository,
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
          );
        }
        return SplashScreen();
      },
    );
  }
}
