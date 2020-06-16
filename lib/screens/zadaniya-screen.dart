import 'package:flutter/material.dart';

class ZadaniyaScreen extends StatefulWidget {
  ZadaniyaScreen({Key key}) : super(key: key);

  @override
  _ZadaniyaScreenState createState() => _ZadaniyaScreenState();
}

class _ZadaniyaScreenState extends State<ZadaniyaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            expandedHeight: 120,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Разборы заданий',
                textAlign: TextAlign.center,
              ),
              centerTitle: true,
            ),
          ),
        ],
      ),
    );
  }
}