import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'detail_products_event.dart';
part 'detail_products_state.dart';

class DetailProductsBloc extends Bloc<DetailProductsEvent, DetailProductsState> {
  DetailProductsBloc() : super(DetailProductsInitial()) {
    on<DetailProductsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
