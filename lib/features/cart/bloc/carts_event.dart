part of 'carts_bloc.dart';

@immutable
sealed class CartsEvent {}

class CartInitialEvent extends CartsEvent {}

class CartRemoveFromCartEvent extends CartsEvent {
  final ProductDataModel productDataModel;

  CartRemoveFromCartEvent({required this.productDataModel});
}
