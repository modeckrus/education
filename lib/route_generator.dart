import 'package:education/screens/add-group-screen.dart';
import 'package:education/screens/add-state-screen.dart';
import 'package:education/screens/error_screen.dart';
import 'package:education/screens/list_screen.dart';
import 'package:education/screens/main_formuls-screen.dart';
import 'package:education/screens/theorems-screen.dart';
import 'package:education/screens/zadaniya-screen.dart';
import 'package:education/user_repository.dart';
import 'package:education/zefyr/editor-page.dart';
import 'package:education/zefyr/formula-editor-widget.dart';
import 'package:education/zefyr/reading-page.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbols.dart';

import 'main.dart';
import 'screens/theory-screen.dart';
import 'screens/thermins-screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(
      RouteSettings settings, UserRepository userRepository) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => MyHomePage(
            userRepository: userRepository,
          ),
        );
        break;
      case '/mainformuls':
        return MaterialPageRoute(
            builder: (_) => MainFormulsScreen(
                  doc: args,
                ));
        break;
      case '/theoremsScreen':
        return MaterialPageRoute(builder: (_) => TheoremsScreen());
        break;
      case '/theoryScreen':
        return MaterialPageRoute(builder: (_) => TheorySceen());
        break;
      case '/therminsScreen':
        return MaterialPageRoute(builder: (_) => TherminsScreen());
        break;
      case '/zadaniyaScreen':
        return MaterialPageRoute(builder: (_) => ZadaniyaScreen());
        break;
      case '/list':
        return MaterialPageRoute(builder: (_) => ListScreen(doc: args));
        break;
      case '/writeArticle':
        return MaterialPageRoute(builder: (_) => EditorPage(doc: args));
      case '/readingPage':
        return MaterialPageRoute(builder: (_) => ReadingPage(doc: args));
      case '/addstate':
        return MaterialPageRoute(builder: (_) => AddStateScreen(doc: args));
      case '/addgroup':
        return MaterialPageRoute(builder: (_) => AddGroupPage(doc: args));
      case '/formulaEditor':
        return MaterialPageRoute(
            builder: (_) => FormulaEditorWidget(
                  editor: args,
                ));
      default:
        return MaterialPageRoute(builder: (_) => ErrorScreen());
        break;
    }
  }
}
