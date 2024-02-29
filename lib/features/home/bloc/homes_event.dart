part of 'homes_bloc.dart';

@immutable
sealed class HomesEvent {}

class HomeInitialEvent extends HomesEvent {}

// BUTTON ACTION STATE
class HomeProductWhishlistButtonClickedEvent extends HomesEvent {
  final ProductDataModel clickedProduct;

  HomeProductWhishlistButtonClickedEvent({required this.clickedProduct});
}

class HomeProductCartButtonClickedEvent extends HomesEvent {
  final ProductDataModel clickedProduct;

  HomeProductCartButtonClickedEvent({required this.clickedProduct});
}

// NAVIGATE EVENT
class HomeWishlistButtonNavigateEvent extends HomesEvent {}

class HomeCartButtonNavigateEvent extends HomesEvent {}

class HomeCardProdukButtonNavigateEvent extends HomesEvent {
  final ProductDataModel clickedProduct;

  HomeCardProdukButtonNavigateEvent({required this.clickedProduct});
}

class HomeSearchProductEvent extends HomesEvent {
  final String query;

  HomeSearchProductEvent({required this.query});
}

class HomeFilteredProductEvent extends HomesEvent {
  final String filterType;

  HomeFilteredProductEvent({required this.filterType});
}
