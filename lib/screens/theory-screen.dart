import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education/searching/bloc/searching_bloc.dart';
import 'package:education/widgets/sliver_listtile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TheorySceen extends StatefulWidget {
  TheorySceen({Key key}) : super(key: key);
  @override
  _TheorySceenState createState() => _TheorySceenState();
}

class _TheorySceenState extends State<TheorySceen> {
  TextEditingController _searchController = TextEditingController();
  bool isSearching = true;
  SearchingBloc bloc;
  @override
  void initState() {
    bloc = SearchingBloc();
    _searchController.addListener(onSearchEditing);
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  void onSearchEditing() async {
    bloc.add(Search(_searchController.text,
        lang: Localizations.localeOf(context).languageCode));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          isSearching? SliverAppBar(
            actions: [
              IconButton(
                onPressed: () {
                  setState(() {
                    isSearching = !isSearching;
                  });
                },
                icon: Icon(Icons.close),
              ),
            ],
            floating: true,
            pinned: true,
            expandedHeight: 120,
            flexibleSpace: FlexibleSpaceBar(
              title: TextFormField(
                autofocus: true,
                controller: _searchController,
              ),
              centerTitle: true,
            ),
          ):SliverAppBar(
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
          isSearching? BlocBuilder(
            bloc: bloc,
            builder: (context, state) {
              if (state is SearchEnd) {
                return SliverList(
                    delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return SliverListTile(doc: state.docs[index]);
                  },
                  childCount: state.docs.length,
                ));
              }
              return SliverToBoxAdapter(child: Container());
            },
          ):SliverToBoxAdapter(
            child: Container(),
          )
        ],
      ),
    );
  }
}

class SearchSliverAppBar extends StatefulWidget {
  const SearchSliverAppBar({
    Key key,
  }) : super(key: key);

  @override
  _SearchSliverAppBarState createState() => _SearchSliverAppBarState();
}

class _SearchSliverAppBarState extends State<SearchSliverAppBar> {
  TextEditingController _searchController = TextEditingController();
  bool isSearching = true;
  @override
  void initState() {
    _searchController.addListener(onSearchEditing);
    super.initState();
  }

  void onSearchEditing() async {
    var snap = await Firestore.instance
        .collectionGroup('list')
        .where('lang', isEqualTo: 'en')
        .where('tags', arrayContains: _searchController.text)
        .limit(10)
        .orderBy('title')
        .getDocuments();
    for (var doc in snap.documents) {
      print(doc.documentID);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isSearching) {
      return SliverAppBar(
        actions: [
          IconButton(
            onPressed: () async {},
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
              });
            },
            icon: Icon(Icons.close),
          ),
        ],
        floating: true,
        pinned: true,
        expandedHeight: 120,
        flexibleSpace: FlexibleSpaceBar(
          title: TextFormField(
            autofocus: true,
            controller: _searchController,
          ),
          centerTitle: true,
        ),
      );
    }
    if (!isSearching) {
      return SliverAppBar(
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
              });
            },
            icon: Icon(Icons.search),
          )
        ],
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
      );
    }
  }
}
