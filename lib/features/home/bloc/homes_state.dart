part of 'homes_bloc.dart';

@immutable
// Initial primary State
sealed class HomesState {}

abstract class HomeActionState extends HomesState {}

// HOME STTE
final class HomesInitial extends HomesState {}

class HomeLoadingState extends HomesState {}

class HomeLoadedSuccessState extends HomesState {
  final List<ProductDataModel> products;

  HomeLoadedSuccessState({required this.products});
}

class HomeErrorState extends HomesState {}

class HomeNoSearchResultState extends HomesState {}

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

class HomeFilteredProductState extends HomesState {
  final List<ProductDataModel> filteredProducts;

  HomeFilteredProductState({required this.filteredProducts});
}
