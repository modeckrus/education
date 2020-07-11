import 'package:education/localization/localizations.dart';
import 'package:flutter/material.dart';

class TitleEditor extends StatefulWidget {
  final TextEditingController controller;
  TitleEditor({Key key, @required this.controller}) : super(key: key);

  @override
  _TitleEditorState createState() => _TitleEditorState();
}

class _TitleEditorState extends State<TitleEditor> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (String title) {},
      controller: widget.controller,
      maxLength: 120,
      decoration: InputDecoration(
          errorText: null, labelText: AppLocalizations().justTitle),
    );
  }
}
