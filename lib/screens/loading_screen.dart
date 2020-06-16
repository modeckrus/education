import 'package:education/localization/localizations.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  String loadingText;
  LoadingScreen({Key key, this.loadingText}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    if(widget.loadingText == '' || widget.loadingText == null){
      widget.loadingText = AppLocalizations.of(context).loading;
    }
    return Center(
      child: Text(widget.loadingText),
    );
  }
}