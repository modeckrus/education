import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:zefyr/zefyr.dart';
import 'package:quill_delta/quill_delta.dart';

import 'image-delegator.dart';

class ReadingPage extends StatefulWidget {
  ReadingPage({Key key}) : super(key: key);

  @override
  _ReadingPageState createState() => _ReadingPageState();
}

class _ReadingPageState extends State<ReadingPage> {
  Future<NotusDocument> _loadDocument() async {
    final file = File(Directory.systemTemp.path + "/quick_start.json");
    if (await file.exists()) {
      final contents = await file.readAsString();
      return NotusDocument.fromJson(jsonDecode(contents));
    }
    final Delta delta = Delta()..insert("Zefyr Quick Start\n");
    return NotusDocument.fromDelta(delta);
  }

  @override
  Widget build(BuildContext context) {
    //final initDoc = NotusDocument.fromJson(jsonDecode('[{"insert":"Loading"},{"insert":"\n","attributes":{"heading":1}}]'));
    return SafeArea(
      child: Scaffold(
        body: ZefyrScaffold(
          child: Center(
            child: FutureBuilder<NotusDocument>(
                //initialData: initDoc,
                future: _loadDocument(),
                builder: (context, snapshot) {
                  //Todo: check for null
                  if (!snapshot.hasData || snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Loading',
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    );
                  }

                  return MzefyrEditor(doc: snapshot.data);
                }),
          ),
        ),
      ),
    );
  }
}

class MzefyrEditor extends StatefulWidget {
  MzefyrEditor({Key key, this.doc}) : super(key: key);
  final NotusDocument doc;
  @override
  _MzefyrEditorState createState() => _MzefyrEditorState();
}

class _MzefyrEditorState extends State<MzefyrEditor> {
  /// Allows to control the editor and the document.
  ZefyrController _controller;

  /// Zefyr editor like any other input field requires a focus node.
  FocusNode _focusNode;
  @override
  void initState() {
    super.initState();
    _controller = ZefyrController(widget.doc);
    _focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return ZefyrEditor(
      controller: _controller,
      focusNode: _focusNode,
      mode: ZefyrMode.select,
      imageDelegate: const MyAppZefyrImageDelegate(),
    );
  }
}
