part of 'settinguser_bloc.dart';

abstract class SettinguserState extends Equatable {
  const SettinguserState();
  @override
  List<Object> get props => [];
}


class NextButtonFailS extends SettinguserState{}

class NextButtonOkS extends SettinguserState{}

class NextButtonLoadingS extends SettinguserState{}

class NextButtonErrorS extends SettinguserState{}