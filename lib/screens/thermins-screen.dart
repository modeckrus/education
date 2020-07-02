import 'package:education/zefyr/editor-page.dart';
import 'package:education/zefyr/reading-page.dart';
import 'package:flutter/material.dart';

class TherminsScreen extends StatefulWidget {
  TherminsScreen({Key key}) : super(key: key);

  @override
  _TherminsScreenState createState() => _TherminsScreenState();
}

class _TherminsScreenState extends State<TherminsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ReadingPage(
        path: 'test.json',
      ),
    );
  }
}
