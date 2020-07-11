import 'package:bloc/bloc.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    // print('Event: ' + event + '; Bloc: ' + bloc.toString());
    super.onEvent(bloc, event);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    // print('Error: ' +
    //     error.toString() +
    //     '; bloc: ' +
    //     bloc.toString() +
    //     '; stacktrace: ' +
    //     stacktrace.toString());
    super.onError(bloc, error, stacktrace);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    // print(
    //     'Transition: ' + transition.toString() + '; bloc: ' + bloc.toString());
    super.onTransition(bloc, transition);
  }
}
