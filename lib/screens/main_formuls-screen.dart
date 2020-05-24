import 'package:flutter/material.dart';

class MainFormulsScreen extends StatefulWidget {
  MainFormulsScreen({Key key}) : super(key: key);

  @override
  _MainFormulsScreenState createState() => _MainFormulsScreenState();
}

class _MainFormulsScreenState extends State<MainFormulsScreen> {
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
                'Основные формулы',
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
