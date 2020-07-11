import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education/authentication/bloc/authentication_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../user_repository.dart';
part 'settinguser_event.dart';
part 'settinguser_state.dart';

class SettinguserBloc extends Bloc<SettinguserEvent, SettinguserState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  SettinguserBloc(this.userRepository, this.authenticationBloc)
      : super(NextButtonFailS());

  @override
  Stream<SettinguserState> mapEventToState(
    SettinguserEvent event,
  ) async* {
    if (event is NextButtonOkE) {
      yield NextButtonOkS();
    }
    if (event is NextButtonFailE) {
      yield NextButtonFailS();
    }
    if (event is NextButtonPressedE) {
      yield* _mapNextButtonPressedE(
          name: event.name,
          surname: event.surname,
          nick: event.nick,
          avatar: event.avatar);
    }
  }

  Stream<SettinguserState> _mapNextButtonPressedE(
      {@required String name,
      @required String nick,
      @required String surname,
      @required String avatar}) async* {
    try {
      yield NextButtonLoadingS();
      final user = await userRepository.getUser();
      await Firestore.instance
          .collection('user')
          .document(user.uid)
          .updateData({
        'Avatar': avatar,
        'Name': name,
        'Nick': nick,
        'Surname': surname,
        'IsSetted': true,
      });
      authenticationBloc.add(LoggedIn());
    } catch (e) {
      yield NextButtonErrorS();
      await Future.delayed(Duration(seconds: 1));
      yield NextButtonOkS();
    }
  }
}
