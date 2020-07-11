import 'package:flutter/material.dart';

class Formula {
  final String path;
  final String uid;
  final String tex;
  final List<String> tags;
  final String title;

  Formula(
      {@required this.path,
      @required this.uid,
      @required this.tex,
      @required this.tags,
      @required this.title});
  Map<String, dynamic> toJson() {
    return {'title': title, 'uid': uid, 'tex': tex, 'tags': tags, 'path': path};
  }

  factory Formula.fromJson(Map<String, dynamic> json) {
    return Formula(
        title: json['title'],
        path: json['path'],
        uid: json['uid'],
        tex: json['tex'],
        tags: json['tags']);
  }
  @override
  String toString() {
    return toJson().toString();
  }
}
// await Firestore.instance.collection('formulas').add({
//   'path': path,
//   'uid': GetIt.I.get<FirebaseUser>().uid,
//   'tex': _controller.text,
//   'tags': tags
// });
