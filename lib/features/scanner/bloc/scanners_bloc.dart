import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'scanners_event.dart';
part 'scanners_state.dart';

class ScannersBloc extends Bloc<ScannersEvent, ScannersState> {
  ScannersBloc() : super(ScannersInitial()) {
    on<ScannerInitialEvent>(scannerInitialEvent);
    on<ScannerNavigatToCartEvent>(scannerNavigatToCartEvent);
  }

  FutureOr<void> scannerInitialEvent(
      ScannerInitialEvent event, Emitter<ScannersState> emit) {}

  FutureOr<void> scannerNavigatToCartEvent(
      ScannerNavigatToCartEvent event, Emitter<ScannersState> emit) {
    emit(ScannerNavigateToCartPageActionState());
  }
}
