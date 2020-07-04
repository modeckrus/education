import 'package:education/localization/localizations.dart';
import 'package:flutter/material.dart';

class TagsEditor extends StatefulWidget {
  @override
  _TagsEditorState createState() => _TagsEditorState();
}

class _TagsEditorState extends State<TagsEditor> {
  List<String> tags;
  TextEditingController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tags = List();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    var tagsWidget = List<Widget>();
    tags.forEach((element) {
      tagsWidget.add(Text(element));
    });
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.min,
      children: [
        tagsWidget == null
            ? Stack(
                children: tagsWidget,
              )
            : Text(AppLocalizations().addTags),
        TextField(
          controller: _controller,
          onChanged: (ntag) {
            print(ntag);
            if (ntag[ntag.length] == 'k') {}
          },
        )
      ],
    );
  }
}
