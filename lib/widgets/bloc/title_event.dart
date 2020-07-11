part of 'title_bloc.dart';

abstract class TitleEvent extends Equatable {
  const TitleEvent();
  @override
  List<Object> get props => [];
}

class TitleChanged extends TitleEvent {
  final String title;

  TitleChanged(this.title);
  @override
  String toString() {
    // TODO: implement toString
    return 'TitleChanged: ' + title;
  }
}
