part of 'carts_bloc.dart';

@immutable
sealed class CartsState {}

abstract class CartActionState extends CartsState {}

final class CartsInitial extends CartsState {}

class CartSuccessState extends CartsState {
  final List<ProductDataModel> cartItems;

  CartSuccessState({required this.cartItems});
}
