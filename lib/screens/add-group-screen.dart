import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education/localization/localizations.dart';
import 'package:education/service/lang-codes.dart';
import 'package:education/widgets/lang_dropdown.dart';
import 'package:education/widgets/tags-editor.dart';
import 'package:flutter/material.dart';

class AddGroupPage extends StatefulWidget {
  final DocumentSnapshot doc;

  const AddGroupPage({Key key, @required this.doc}) : super(key: key);
  @override
  _AddGroupPageState createState() => _AddGroupPageState();
}

class _AddGroupPageState extends State<AddGroupPage> {
  void onlangchange(String nlang) {
    lang = nlang;
    print(lang);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleController = TextEditingController();
    _tagController = TextEditingController();
  }

  TextEditingController _titleController;
  TextEditingController _tagController;

  String lang;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations().titleAddState),
        ),
        body: SingleChildScrollView(
          child: Column(
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
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    AppLocalizations.of(context).langof,
                    style: TextStyle(fontSize: 20),
                  ),
                  LangDropDownButton(
                    onlangchange: onlangchange,
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                child: TextField(
                    decoration: InputDecoration(
                  labelText: AppLocalizations.of(context).justTitle,
                )),
              ),
              TagsEditor(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: RaisedButton(
                  color: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  onPressed: () {},
                  child: Container(
                    // width: double.infinity,
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
      ),
    );
  }
}
