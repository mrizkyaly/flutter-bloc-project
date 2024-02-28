part of 'homes_bloc.dart';

@immutable
sealed class HomesState {}

abstract class HomeActionState extends HomesState {}

final class HomesInitial extends HomesState {}

class HomeLoadingState extends HomesState {}

class HomeLoadedSuccessState extends HomesState {
  final List<ProductDataModel> products;

  HomeLoadedSuccessState({required this.products});
}

class HomeErrorState extends HomesState {}

// NAVIGATE STATE
class HomeNavigateToWishlistPageActionState extends HomeActionState {}

class HomeNavigateToCartPageActionState extends HomeActionState {}

class HomeNavigateToDetailProductPageActionState extends HomeActionState {
  final ProductDataModel clickedProduct;

  HomeNavigateToDetailProductPageActionState(this.clickedProduct);
}

//BUTTON ACTION STATE
class HomeProductItemWishlistedActionState extends HomeActionState {}

class HomeProductItemChartedActionState extends HomeActionState {}
