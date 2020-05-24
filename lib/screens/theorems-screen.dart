import 'package:flutter/material.dart';

class TheoremsScreen extends StatefulWidget {
  TheoremsScreen({Key key}) : super(key: key);

  @override
  _TheoremsScreenState createState() => _TheoremsScreenState();
}

class _TheoremsScreenState extends State<TheoremsScreen> {
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
                'Теоремы и аксиомы',
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