part of 'title_bloc.dart';

abstract class TitleState extends Equatable {
  const TitleState();
  @override
  List<Object> get props => [];
}

class TitleOkS extends TitleState {}

class TitleFailS extends TitleState {}
