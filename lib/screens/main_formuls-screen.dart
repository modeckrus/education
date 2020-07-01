import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education/localization/localizations.dart';
import 'package:education/widgets/my_sliverappbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
                .orderBy('order')
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
                    final d = data.documents[index].data;
                    switch (d['type']) {
                      case 'simpleText':
                        return Container(
                          child: Text(d['body'], style: TextStyle(
                            fontSize: 20,
                          ),),
                        );
                        break;
                      case 'networkSvg':
                      print('network svg');
                        return FittedBox(
                          fit: BoxFit.fitWidth,
                          child: SvgPicture.network(
                            d['url'],
                            placeholderBuilder: (context) {
                              return Container(
                                height: 20,
                                width: 200,
                              );
                            },
                            color: Colors.white,
                            fit: BoxFit.fitWidth,
                          ),
                        );
                      case 'richText':
                        return RichText(text: TextSpan(
                          style: TextStyle(
                            fontSize: 20,
                          ),
                          children: [
                            TextSpan(text: 'It\'s '),
                            TextSpan(text: 'Show youtself', style: TextStyle(
                              decoration: TextDecoration.underline
                            )),
                            TextSpan(text: ' jopa '),
                          ]
                        ));
                      default:
                    }
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
