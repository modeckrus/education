import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education/localization/localizations.dart';
import 'package:flutter/material.dart';

class MySliverAppBar extends StatelessWidget {
  final String path;
  const MySliverAppBar({
    Key key,
    @required this.path
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      expandedHeight: 120,
      flexibleSpace: FlexibleSpaceBar(
        title: FutureBuilder(
            future: Firestore.instance.document(path)
                .get(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> data) {
              if (!data.hasData) {
                return Text(
                  AppLocalizations.of(context).title,
                  textAlign: TextAlign.center,
                );
              }
              if(data.hasError){
                return Text(AppLocalizations.of(context).error, textAlign: TextAlign.center,);
              }

              var title = data.data.data['title'];
              return Text(
                title??AppLocalizations.of(context).error,
                textAlign: TextAlign.center,
              );
            }),
        centerTitle: true,
      ),
    );
  }
}