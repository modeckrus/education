part of 'button_bloc.dart';

abstract class ButtonState extends Equatable {
  const ButtonState();
    @override
  List<Object> get props => [];
}

class ButtonDisabled extends ButtonState {

}

class ButtonEnabled extends ButtonState{

}