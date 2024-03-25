import 'package:flutter_bloc/flutter_bloc.dart';

class CustomBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print("${bloc.runtimeType} ${change.currentState} change to  ${change.nextState}");
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    print("${bloc.runtimeType}  ${error.toString()}  ${stackTrace.toString()}");
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print("${bloc.runtimeType} closed.");
  }

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print("${bloc.runtimeType} created.");
  }

  // @override
  // void onTransition(Bloc bloc, Transition transition) {
  //   // TODO: implement onTransition
  //   super.onTransition(bloc, transition);
  // }
}
