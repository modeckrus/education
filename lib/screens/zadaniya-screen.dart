import 'dart:convert';

import 'package:education/service/fstorage-cache-manager.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ZadaniyaScreen extends StatefulWidget {
  ZadaniyaScreen({Key key}) : super(key: key);

  @override
  _ZadaniyaScreenState createState() => _ZadaniyaScreenState();
}

class _ZadaniyaScreenState extends State<ZadaniyaScreen> {
  String text;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    text = 'press the button to start';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Column(
              children: [
                Text(text),
                RaisedButton(
                  onPressed: () async {
                    // final file =
                    //     await FirebaseCacheManager().getSingleFile('test.json');
                    // setState(() {
                    //   text = file.readAsStringSync();
                    // });
                    // final data = await FirebaseStorage.instance
                    //     .ref()
                    //     .child('test.json')
                    //     .getData(10 * 1024);
                    // setState(() {
                    //   text = utf8.decode(data);
                    // });
                    final file =
                        await FStoreCacheManager().getFStoreFile('test.json');
                    setState(() {
                      text = file.readAsStringSync();
                    });
                  },
                  child: Text('download the file'),
                ),
              ],
            ),
          )),
    );
  }
}
