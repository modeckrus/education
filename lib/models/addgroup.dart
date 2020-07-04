import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum GroupRoutes { List, Theory, Task, Formula }

class AddGroup extends Equatable {
  final String lang;
  final String title;
  final GroupRoutes route;
  final List<String> tags;

  AddGroup(
      {@required this.lang,
      @required this.title,
      @required this.route,
      @required this.tags});
  @override
  List<Object> get props => [lang, title, route, tags];
}
