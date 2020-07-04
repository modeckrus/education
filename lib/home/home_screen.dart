import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education/localization/localizations.dart';
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
  int _selectedIndex = 0;
  Widget page(context) {
    if (_selectedIndex == 0) {
      return StreamBuilder(
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
            var countryCode = Localizations.localeOf(context).languageCode;
            print({'Locale: ': countryCode});
            // QuerySnapshot querySnap = snap.data;
            // print(querySnap.documents);
            //print(snap.data.documents['Title'].data['title']);
            return CustomScrollView(
              slivers: [
                MySliverAppBar(
                  path: '/routes/' + countryCode,
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
          });
    } else if (_selectedIndex == 1) {
      return Center(
        child: Text('Page 2'),
      );
    } else if (_selectedIndex == 2) {
      return Center(
        child: Text('Page 3'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // String code = Localizations.localeOf(context).countryCode;
          // var doc = await Firestore.instance.collection('routes').document(code);
          // print(doc.path);
          FirebaseAuth.instance.signOut();
        },
        child: Icon(Icons.ac_unit),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text(AppLocalizations.of(context).home)),
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text(AppLocalizations.of(context).home)),
          BottomNavigationBarItem(
              icon: Icon(Icons.view_headline),
              title: Text(AppLocalizations.of(context).more))
        ],
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: page(context),
    );
  }
}
