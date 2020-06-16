import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

part 'searching_event.dart';
part 'searching_state.dart';

class SearchingBloc extends Bloc<SearchingEvent, SearchingState> {
  @override
  SearchingState get initialState => SearchingInitial();

  @override
  Stream<SearchingState> mapEventToState(
    SearchingEvent event,
  ) async* {
    if(event is Search){
      print(event.query);
      var snap = await Firestore.instance
        .collectionGroup('list')
        .where('lang', isEqualTo: event.lang)
        .where('tags', arrayContains: event.query)
        .limit(5)
        .orderBy('title')
        .getDocuments();
      if(snap.documents.isEmpty){
        return;
      }
      print('search');
      yield SearchEnd(snap.documents);
    }
  }
}
