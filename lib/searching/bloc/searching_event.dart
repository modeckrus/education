part of 'searching_bloc.dart';

abstract class SearchingEvent extends Equatable {
  const SearchingEvent();
}

class Search extends SearchingEvent{
  final String query;
  final String lang;
  Search(this.query, {@required this.lang});
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}