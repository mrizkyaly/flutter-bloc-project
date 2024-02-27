import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'whistlists_event.dart';
part 'whistlists_state.dart';

class WhistlistsBloc extends Bloc<WhistlistsEvent, WhistlistsState> {
  WhistlistsBloc() : super(WhistlistsInitial()) {
    on<WhistlistsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
