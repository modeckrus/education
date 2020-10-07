import 'dart:convert';
import 'dart:typed_data';

<<<<<<< HEAD
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education/models/formula.dart';
import 'package:education/service/fstorage-cache-manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
=======
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
>>>>>>> 0a409622a99dbf6ead85b9d41416de4add37f8f1

class ZadaniyaScreen extends StatefulWidget {
  ZadaniyaScreen({Key key}) : super(key: key);

  @override
  _ZadaniyaScreenState createState() => _ZadaniyaScreenState();
}

class _ZadaniyaScreenState extends State<ZadaniyaScreen> {
  String text;
  TextEditingController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Column(
              children: [
                text == null
                    ? Text('Press')
                    : Container(
                        child: SvgPicture.string(
                          text,
                          color: Colors.white,
                        ),
                        width: 100,
                        height: 100,
                      ),
                TextField(
                  controller: _controller,
                ),
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
<<<<<<< HEAD
                    final formula = Formula(
                        formula: 'a + b',
                        title: 'Test',
                        uid: GetIt.I.get<FirebaseUser>().uid,
                        tags: ['Test'],
                        state: 'process');
                    print(formula);
                    Firestore.instance
                        .collection('formulas')
                        .add(formula.toJSON());
=======
                    //CloudFunctions.instance
                    //  .useFunctionsEmulator(origin: 'http://localhost:4000/');
                    // final Map<String, String> headers = {
                    //   'Content-Type': 'application/javascript',
                    //   'Accept': '*/*',
                    //   'User-Agent': 'PostmanRuntime/7.26.1',
                    //   'Accept-Encoding': 'gzip, deflate, br',
                    //   'Connection': 'keep-alive'
                    // };
                    // final response = await http.post(
                    //     'https://us-central1-education-modeck.cloudfunctions.net/checkFireStorage ',
                    //     encoding: Encoding.getByName('utf8'),
                    //     body: _controller.text);
                    // print(response.statusCode);
                    // print(response.headers);
                    // print(response.contentLength);
                    // print(response.bodyBytes);
                    // print(response.body);
                    // setState(() {
                    //   text = response.body;
                    // });

                    try {
                      Response response = await Dio().post(
                          'https://us-central1-education-modeck.cloudfunctions.net/checkFireStorage',
                          options: Options(
                              followRedirects: false,
                              contentType: 'text/plain',
                              validateStatus: (status) {
                                return status < 500;
                              }),
                          data: _controller.text);
                      print(response.statusCode);
                      print(response.statusMessage);
                      print(response.data);
                      if (response.statusCode == 200) {
                        setState(() {
                          text = response.data;
                        });
                      }
                    } catch (e) {
                      print(e);
                    }
>>>>>>> 0a409622a99dbf6ead85b9d41416de4add37f8f1
                  },
                  child: Text('download the file'),
                ),
              ],
            ),
          )),
    );
  }
}
