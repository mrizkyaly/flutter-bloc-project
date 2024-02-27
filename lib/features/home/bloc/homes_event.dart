part of 'homes_bloc.dart';

@immutable
sealed class HomesEvent {}

class HomeInitialEvent extends HomesEvent {}

class HomeProductWhishlistButtonClickedEvent extends HomesEvent {
  final ProductDataModel clickedProduct;

  HomeProductWhishlistButtonClickedEvent({required this.clickedProduct});
}

class HomeProductCartButtonClickedEvent extends HomesEvent {
  final ProductDataModel clickedProduct;

  HomeProductCartButtonClickedEvent({required this.clickedProduct});
}

class HomeWishlistButtonNavigateEvent extends HomesEvent {}

class HomeCartButtonNavigateEvent extends HomesEvent {}
