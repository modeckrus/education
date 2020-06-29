part of 'settinguser_bloc.dart';

abstract class SettinguserEvent extends Equatable {
  const SettinguserEvent();
  @override
  List<Object> get props => null;
}

class NextButtonPressedE extends SettinguserEvent{
  final String name;
  final String surname;
  final String nick;
  final String avatar;

  NextButtonPressedE({@required this.name, @required this.surname, @required this.nick, @required this.avatar});
  @override
  List<Object> get props => [name, surname, nick, avatar];
  @override
  String toString() {
  return 'NextButtonPressedEvent { name: $name, surname: $surname, nick: $nick, avatar: $avatar }';
   }
}
class NextButtonOkE extends SettinguserEvent{}
class NextButtonFailE extends SettinguserEvent{}