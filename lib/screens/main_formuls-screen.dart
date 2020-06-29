import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education/widgets/my_sliverappbar.dart';
import 'package:flutter/material.dart';

import 'error_screen.dart';
import 'loading_screen.dart';

class MainFormulsScreen extends StatefulWidget {
  MainFormulsScreen({Key key, @required this.doc}) : super(key: key);
  final DocumentSnapshot doc;
  @override
  _MainFormulsScreenState createState() => _MainFormulsScreenState();
}

class _MainFormulsScreenState extends State<MainFormulsScreen> {
  @override
  Widget build(BuildContext context) {
    final stream =
        widget.doc.reference.firestore.collection('list').snapshots();

    return Scaffold(
      key: UniqueKey(),
      body: CustomScrollView(
        key: UniqueKey(),
        slivers: [
          SliverAppBar(
            centerTitle: true,
            pinned: true,
            floating: true,
            title: Text(widget.doc.data['title']),
          ),
          // SliverList(
          //   delegate: SliverChildBuilderDelegate(
          //     (context, index){
          //       return Container(
          //         height: 80,
          //         color: Colors.black,
          //       );
          //     },
          //     childCount: 10,
          //   ),
          // ),
          StreamBuilder(
            stream: Firestore.instance
                .collection(widget.doc.reference.path + '/data')
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
                    return Container(
                      child:Container()
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
