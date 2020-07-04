import 'package:education/localization/localizations.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatefulWidget {
  String error;
  ErrorScreen({Key key, this.error}) : super(key: key);

  @override
  _ErrorScreenState createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    if (widget.error == '' || widget.error == null) {
      widget.error = AppLocalizations.of(context).error;
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text(widget.error),
        ),
      ),
    );
  }
}
