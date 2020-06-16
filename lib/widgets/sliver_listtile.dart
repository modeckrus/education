import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SliverListTile extends StatefulWidget {
  SliverListTile({Key key, @required this.doc}) : super(key: key);
  final DocumentSnapshot doc;
  @override
  _SliverListTileState createState() => _SliverListTileState();
}

class _SliverListTileState extends State<SliverListTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
                onTap: () async{
                  print('tapped');
                  Navigator.pushNamed(context, widget.doc.data['route'], arguments: widget.doc);
                },
                child: Container(
                  height: 80,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      alignment: Alignment.center,
                      color: Colors.black38,
                      child: Text(
                        widget.doc.data['title'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              );
  }
}