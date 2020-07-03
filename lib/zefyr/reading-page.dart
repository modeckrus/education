import 'dart:convert';
import 'dart:io';

import 'package:education/service/fstorage-cache-manager.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:zefyr/zefyr.dart';
import 'package:quill_delta/quill_delta.dart';

import 'image-delegator.dart';

class ReadingPage extends StatefulWidget {
  final String path;
  ReadingPage({Key key, @required this.path}) : super(key: key);

  @override
  _ReadingPageState createState() => _ReadingPageState();
}

class _ReadingPageState extends State<ReadingPage> {
  Future<NotusDocument> _loadDocument() async {
    final Delta delta = Delta()..insert("Something go wrong\n");
    final file = await FStoreCacheManager().getFStoreFile(widget.path);

    if (await file.exists()) {
      final String contents = await file.readAsString();
      if (contents == null || contents == '') {
        return NotusDocument.fromDelta(delta);
      }
      return NotusDocument.fromJson(jsonDecode(contents));
    }

    return NotusDocument.fromDelta(delta);
  }

  @override
  Widget build(BuildContext context) {
    //final initDoc = NotusDocument.fromJson(jsonDecode('[{"insert":"Loading"},{"insert":"\n","attributes":{"heading":1}}]'));
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.clear_all),
              onPressed: () {
                FStoreCacheManager().emptyCache();
              },
            )
          ],
        ),
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
