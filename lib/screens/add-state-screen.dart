import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education/localization/localizations.dart';
import 'package:flutter/material.dart';

//Specify the lang
//Specify the

class AddStateScreen extends StatefulWidget {
  final DocumentSnapshot doc;

  const AddStateScreen({Key key, @required this.doc}) : super(key: key);
  @override
  _AddStateScreenState createState() => _AddStateScreenState();
}

class _AddStateScreenState extends State<AddStateScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations().titleAddState),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: EdgeInsets.all(30),
                alignment: Alignment.center,
                child: Text(
                  AppLocalizations().topTextforaddState,
                  style: TextStyle(fontSize: 30),
                )),
            Expanded(child: Container()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
              child: RaisedButton(
                color: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                onPressed: () {},
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text(
                    'Add state',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: RaisedButton(
                color: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/addgroup');
                },
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text(
                    'Add group',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
