import 'package:flutter/material.dart';

class TheorySceen extends StatefulWidget {
  TheorySceen({Key key}) : super(key: key);

  @override
  _TheorySceenState createState() => _TheorySceenState();
}

class _TheorySceenState extends State<TheorySceen> {
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
                'Теория',
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