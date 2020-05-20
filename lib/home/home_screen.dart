import 'package:education/localization/localizations.dart';
import 'package:education/messaging/show_notification.dart';
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
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.fiber_new), title: Text('feed')),
        BottomNavigationBarItem(icon: Icon(Icons.ac_unit), title: Text('user'))
      ]),
      body: Center(
        child: SingleChildScrollView(
            child: Column(
          children: [
            Text(AppLocalizations.of(context).homescreen),
            Builder(builder: (context) {
              return RaisedButton(
                onPressed: () {
                  Scaffold.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.black45,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(),
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                      content: Container(
                        width: double.infinity,
                        height: 25,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            CircleAvatar(
                                child: Icon(
                              Icons.add,
                              size: 24,
                            )),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'Title',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ],
                            ),
                            RaisedButton(
                              color: Colors.redAccent,
                              onPressed: () {},
                              child: Text(
                                'press',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      )));
                  // Scaffold.of(context).showBottomSheet((context) => Container(
                  //       height: 200,
                  //       color: Colors.amber,
                  //       child: Center(
                  //         child: Column(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           mainAxisSize: MainAxisSize.min,
                  //           children: <Widget>[
                  //             const Text('BottomSheet'),
                  //             RaisedButton(
                  //               child: const Text('Close BottomSheet'),
                  //               onPressed: () => Navigator.pop(context),
                  //             )
                  //           ],
                  //         ),
                  //       ),
                  //     ));
                },
                child: Text('Hey'),
              );
            }),
          ],
        )),
      ),
    );
  }
}
