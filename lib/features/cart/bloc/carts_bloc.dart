import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_project/data/cart_items.dart';
import 'package:flutter_bloc_project/features/home/models/home_product_data_model.dart';
import 'package:meta/meta.dart';

part 'carts_event.dart';
part 'carts_state.dart';

class CartsBloc extends Bloc<CartsEvent, CartsState> {
  CartsBloc() : super(CartsInitial()) {
    on<CartInitialEvent>(caritInitialEvent);
    on<CartRemoveFromCartEvent>(cartRemoveFromCartEvent);
  }

  FutureOr<void> caritInitialEvent(
      CartInitialEvent event, Emitter<CartsState> emit) {
    emit(CartSuccessState(cartItems: cartItems));
  }

  FutureOr<void> cartRemoveFromCartEvent(
      CartRemoveFromCartEvent event, Emitter<CartsState> emit) {
    cartItems.remove(event.productDataModel);

    emit(CartSuccessState(cartItems: cartItems));

    // get your cartItems
    // check is Your Product model there in your cartItems - true
    // run a funciton to remove that product model from that cartItems
    // emit cartItemRemovedState
  }
}
