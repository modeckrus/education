import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education/widgets/my_sliverappbar.dart';
import 'package:education/widgets/sliver_listtile.dart';
import 'package:flutter/material.dart';

import 'error_screen.dart';
import 'loading_screen.dart';

class ListScreen extends StatefulWidget {
  ListScreen({Key key, @required this.doc}) : super(key: key);
  final DocumentSnapshot doc;
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    final stream =
        widget.doc.reference.firestore.collection('list').snapshots();

    return Scaffold(
      key: UniqueKey(),
      body: CustomScrollView(
        key: UniqueKey(),
        slivers: [
          MySliverAppBar(path: widget.doc.reference.path),
          StreamBuilder(
            stream: Firestore.instance
                .collection(widget.doc.reference.path + '/list')
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!(snapshot.hasData)) {
                return SliverToBoxAdapter(child: LoadingScreen());
              }
              if (snapshot.hasError) {
                return SliverToBoxAdapter(child: ErrorScreen());
              }

              QuerySnapshot data = snapshot.data;
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return SliverListTile(
                      doc: data.documents[index],
                    );
                  },
                  childCount: data.documents.length,
                ),
              );
            },
          ),

          // StreamBuilder(
          //     stream:
          //         widget.doc.reference.firestore.collection('list').snapshots(),
          //     builder: (context, snap) {
          //       if (!snap.hasData) {
          //         return LoadingScreen();
          //       }
          //       if (snap.hasError) {
          //         return ErrorScreen(error: snap.error.toString());
          //       }
          //       print(snap);
          //       return SliverList(
          //         delegate: SliverChildBuilderDelegate(
          //           (context, index){
          //             return SliverListTile(
          //               doc: snap.data.documents[index],
          //             );
          //           },
          //         childCount: snap.data.documents.length,
          //         ),
          //       );
          //     })
        ],
      ),
    );
  }
}
