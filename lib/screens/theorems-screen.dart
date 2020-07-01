import 'package:flutter/material.dart';

class TheoremsScreen extends StatefulWidget {
  TheoremsScreen({Key key}) : super(key: key);

  @override
  _TheoremsScreenState createState() => _TheoremsScreenState();
}

class _TheoremsScreenState extends State<TheoremsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:TextField(
          toolbarOptions: ToolbarOptions(),
        )
      ),
    );
  }
}
