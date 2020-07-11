import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'title_event.dart';
part 'title_state.dart';

class TitleBloc extends Bloc<TitleEvent, TitleState> {
  TitleBloc() : super(TitleOkS());

  @override
  Stream<TitleState> mapEventToState(
    TitleEvent event,
  ) async* {
    if (event is TitleChanged) {
      if (event.title == null || event.title == '' || event.title.length < 2) {
        yield TitleFailS();
      } else {
        yield TitleOkS();
      }
    }
  }
}
