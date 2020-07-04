import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education/searching/bloc/searching_bloc.dart';
import 'package:education/widgets/sliver_listtile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'error_screen.dart';
import 'loading_screen.dart';

class AddStateScreen extends StatefulWidget {
  AddStateScreen({Key key, @required this.doc}) : super(key: key);
  final DocumentSnapshot doc;
  @override
  _AddStateScreenState createState() => _AddStateScreenState();
}

class _AddStateScreenState extends State<AddStateScreen> {
  TextEditingController _searchController = TextEditingController();
  bool isSearching = false;
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
          isSearching
              ? SliverAppBar(
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
                )
              : SliverAppBar(
                  floating: true,
                  pinned: true,
                  expandedHeight: 120,
                  actions: [
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        setState(() {
                          isSearching = !isSearching;
                        });
                      },
                    )
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(
                      widget.doc.data['title'],
                      textAlign: TextAlign.center,
                    ),
                    centerTitle: true,
                  ),
                ),
          isSearching
              ? BlocBuilder(
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
                )
              : StreamBuilder(
                  stream: Firestore.instance
                      .collection(widget.doc.reference.path + '/list')
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!(snapshot.hasData)) {
                      return SliverToBoxAdapter(child: LoadingScreen());
                    }
                    if (snapshot.hasError) {
                      return SliverToBoxAdapter(child: ErrorScreen());
                    }

                    QuerySnapshot data = snapshot.data;
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return SliverListTile(
                            doc: data.documents[index],
                          );
                        },
                        childCount: data.documents.length,
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }
}
