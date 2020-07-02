import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:zefyr/zefyr.dart';

import 'image-delegator.dart';
import 'mtoolbar.dart';

class EditorPage extends StatefulWidget {
  final String path;

  const EditorPage({Key key, @required this.path}) : super(key: key);
  @override
  EditorPageState createState() => EditorPageState();
}

class EditorPageState extends State<EditorPage> {
  /// Allows to control the editor and the document.
  ZefyrController _controller;

  /// Zefyr editor like any other input field requires a focus node.
  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    // Here we must load the document and pass it to Zefyr controller.
    final document = _loadDocument();
    _controller = ZefyrController(document);
    _focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    // Note that the editor requires special `ZefyrScaffold` widget to be
    // one of its parents.

    return Scaffold(
      appBar: AppBar(
        title: Text("Editor page"),
        actions: [
          FlatButton.icon(
              onPressed: () async {
                await _saveDocument(context);
                Navigator.pop(context);
              },
              icon: Icon(Icons.save),
              label: Text('Save'))
        ],
      ),
      body: Builder(
        builder: (context) {
          return ZefyrScaffold(
            child: ZefyrEditor(
              toolbarDelegate: MDZefyrToolbarDelegate(),
              padding: EdgeInsets.all(16),
              controller: _controller,
              focusNode: _focusNode,
              imageDelegate: const MyAppZefyrImageDelegate(),
            ),
          );
        },
      ),
    );
  }

  /// Loads the document to be edited in Zefyr.
  NotusDocument _loadDocument() {
    // For simplicity we hardcode a simple document with one line of text
    // saying "Zefyr Quick Start".
    // (Note that delta must always end with newline.)
    final Delta delta = Delta()..insert("Zefyr Quick Start\n");
    return NotusDocument.fromDelta(delta);
  }

  Future<void> _saveDocument(BuildContext context) async {
    // Notus documents can be easily serialized to JSON by passing to
    // `jsonEncode` directly
    final contents = jsonEncode(_controller.document);
    // For this example we save our document to a temporary file.
    // And show a snack bar on success.
    print(contents);
    final file = File(Directory.systemTemp.path + widget.path);
    // And show a snack bar on success.
    file.writeAsString(contents);
    await FirebaseStorage.instance
        .ref()
        .child(widget.path)
        .putFile(file)
        .onComplete;
  }
}
