import 'package:education/screens/main_formuls-screen.dart';
import 'package:education/screens/theorems-screen.dart';
import 'package:education/user_repository.dart';
import 'package:flutter/material.dart';

import 'main.dart';
import 'screens/theory-screen.dart';
import 'screens/thermins-screen.dart';
import 'screens/zadaniya-screen.dart';

class RouteGenerator{

  static Route<dynamic> generateRoute(RouteSettings settings, UserRepository userRepository){
    final args = settings.arguments;
    switch (settings.name) {
      case '/': 
        return MaterialPageRoute(builder: (_) => MyHomePage(userRepository: userRepository,),);
        break;
      case '/mainformuls': 
        return MaterialPageRoute(builder: (_) => MainFormulsScreen(key: Key('mainFormulsScreen'),));
        break;
      case '/theoremsScreen': 
        return MaterialPageRoute(builder: (_) => TheoremsScreen(key: Key('theoremsScreen'),));
        break;
      case '/theoryScreen': 
        return MaterialPageRoute(builder: (_) => TheorySceen(key: Key('theoryScreen'),));
        break;
      case '/therminsScreen': 
        return MaterialPageRoute(builder: (_) => TherminsScreen(key: Key('therminsScreen'),));
        break;
      case '/zadaniyaScreen': 
        return MaterialPageRoute(builder: (_) => ZadaniyaScreen(key: Key('zadaniyaScreen'),));
        break;
      
      default:
    }
  }
}