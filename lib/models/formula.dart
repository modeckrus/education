import 'package:flutter/material.dart';

class Formula {
  final String title;
  final String formula;
  final List<String> tags;
  final String state;
  final String uid;

  Formula(
      {@required this.uid,
      @required this.title,
      @required this.formula,
      @required this.tags,
      @required this.state});
  Map<String, dynamic> toJSON() {
    return {
      'title': title,
      'formula': formula,
      'tags': tags,
      'state': state,
      'uid': uid
    };
  }

  factory Formula.fromJSON(Map<String, dynamic> json) {
    return Formula(
        formula: json['formula'],
        title: json['title'],
        tags: json['tags'],
        uid: json['uid'],
        state: json['state']);
  }
  @override
  String toString() {
    return toJSON().toString();
  }
}
