import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education/screens/error_screen.dart';
import 'package:education/screens/loading_screen.dart';
import 'package:education/widgets/my_sliverappbar.dart';
import 'package:education/widgets/sliver_listtile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final FirebaseUser user;
  HomeScreen({Key key, @required this.user}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: ()async {
        String code = Localizations.localeOf(context).countryCode;
        var doc = await Firestore.instance.collection('routes').document(code);
        print(doc.path);
      },
      child: Icon(Icons.ac_unit),),
      body: StreamBuilder(
          stream: Firestore.instance
              .collection('routes')
              .document(Localizations.localeOf(context).languageCode)
              .collection('mainRoutes')
              .snapshots(),
          builder: (context, snap) {
            if (!snap.hasData) {
              return LoadingScreen();
            }
            if (snap.hasError) {
              return ErrorScreen(error: snap.error.toString());
            }
            var countryCode =  Localizations.localeOf(context).languageCode;
            print({'Locale: ': countryCode});
            // QuerySnapshot querySnap = snap.data;
            // print(querySnap.documents);
            //print(snap.data.documents['Title'].data['title']);
            return CustomScrollView(
              slivers: [
                MySliverAppBar(
                  path: '/routes/'+countryCode,
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final doc = snap.data.documents[index];
                      return SliverListTile(doc: doc);
                    },
                    childCount: snap.data.documents.length,
                  ),
                ),
              ],
            );
          }),
    );
  }
}


