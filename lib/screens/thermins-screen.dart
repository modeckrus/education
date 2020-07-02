import 'package:flutter/material.dart';

class TherminsScreen extends StatefulWidget {
  TherminsScreen({Key key}) : super(key: key);

  @override
  _TherminsScreenState createState() => _TherminsScreenState();
}

class _TherminsScreenState extends State<TherminsScreen> {
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
                'Термины и аксиомы',
                textAlign: TextAlign.center,
              ),
              centerTitle: true,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(),
          )
        ],
      ),
    );
  }
}
