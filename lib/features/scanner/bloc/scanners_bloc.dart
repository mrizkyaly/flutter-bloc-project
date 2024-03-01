import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'scanners_event.dart';
part 'scanners_state.dart';

class ScannersBloc extends Bloc<ScannersEvent, ScannersState> {
  ScannersBloc() : super(ScannersInitial()) {
    on<ScannersEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
