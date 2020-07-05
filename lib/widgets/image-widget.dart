import 'package:education/localization/localizations.dart';
import 'package:education/service/fstorage-cache-manager.dart';
import 'package:flutter/material.dart';

class MyImage extends StatefulWidget {
  final String fchild;

  const MyImage({Key key, this.fchild}) : super(key: key);
  @override
  _MyImageState createState() => _MyImageState();
}

class _MyImageState extends State<MyImage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FStoreCacheManager().getFStoreFile(widget.fchild),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(AppLocalizations().error),
            );
          }
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          return Container(
            width: double.infinity,
            child: Image(
              image: FileImage(snapshot.data),
              fit: BoxFit.fitWidth,
            ),
          );
        });
  }
}
