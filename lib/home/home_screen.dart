import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education/localization/localizations.dart';
import 'package:education/messaging/show_notification.dart';
import 'package:education/screens/error_screen.dart';
import 'package:education/screens/loading_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../localization/localizations.dart';
import '../localization/localizations.dart';

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
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, '/mainformuls');
        },
        child: Icon(Icons.add),
      ),
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
            print({'Locale: ': Localizations.localeOf(context).languageCode});
            // QuerySnapshot querySnap = snap.data;
            // print(querySnap.documents);
            //print(snap.data.documents['Title'].data['title']);
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  floating: true,
                  pinned: true,
                  expandedHeight: 120,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(
                      snap.data.documents[0].data['title'],
                      textAlign: TextAlign.center,
                    ),
                    centerTitle: true,
                  ),
                ),
                SliverList(delegate: SliverChildBuilderDelegate(
                  (context, index){
                    if(index == 0){
                      return Container();
                    }
                    return ListTile(
                      leading: Icon(Icons.error, size: 30,),
                      contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                      title: Text(snap.data.documents[index].data['title'], textAlign: TextAlign.start, style: TextStyle(
                        fontSize: 20,
                      ),),
                      onTap: (){
                        String route = snap.data.documents[index].data['route'];
                        DocumentSnapshot doc =  snap.data.documents[index];
                        Navigator.pushNamed(context, route.toString(), arguments: doc.reference.path);
                      },
                    );
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
