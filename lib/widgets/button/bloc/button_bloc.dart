import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'button_event.dart';
part 'button_state.dart';

class ButtonBloc extends Bloc<ButtonEvent, ButtonState> {
  @override
  ButtonState get initialState => ButtonEnabled();

  @override
  Stream<ButtonState> mapEventToState(
    ButtonEvent event,
  ) async* {
    if(event is BStatusChanged){
      if(event.isEnabled){
        yield ButtonEnabled();
      }else{
        yield ButtonDisabled();
      }
    }
  }
}
