import 'package:flutter/material.dart';
import 'package:zefyr/zefyr.dart';

class FormulaEditorWidget extends StatefulWidget {
  final ZefyrScope editor;

  const FormulaEditorWidget({Key key, this.editor}) : super(key: key);
  @override
  _FormulaEditorWidgetState createState() => _FormulaEditorWidgetState();
}

class _FormulaEditorWidgetState extends State<FormulaEditorWidget> {
  TextEditingController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Center(
        child: Column(
          children: [
            Text(
              'Put the formula hear',
              style: TextStyle(fontSize: 24),
            ),
            TextField(
              controller: _controller,
            ),
            RaisedButton(
              onPressed: () {
                widget.editor.formatSelection(
                    NotusAttribute.embed.image('formula±/' + _controller.text));
                Navigator.pop(context);
              },
              child: Text('Send'),
            ),
          ],
        ),
      ),
    );
  }
}
