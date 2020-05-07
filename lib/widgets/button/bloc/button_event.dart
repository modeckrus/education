part of 'button_bloc.dart';

abstract class ButtonEvent extends Equatable {
  const ButtonEvent();
}
class BStatusChanged extends ButtonEvent{
  final bool isEnabled;

  BStatusChanged(this.isEnabled);
  @override
  // TODO: implement props
  List<Object> get props => null;

}