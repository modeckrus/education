part of 'searching_bloc.dart';

abstract class SearchingState extends Equatable {
  const SearchingState();
  @override
  List<Object> get props => [];
}

class SearchingInitial extends SearchingState {

}

class SearchEnd extends SearchingState{
  final List<DocumentSnapshot> docs;

  SearchEnd(this.docs);
  @override
  List<Object> get props => [docs];
}
