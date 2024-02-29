import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_project/data/cart_items.dart';
import 'package:flutter_bloc_project/data/grocery_data.dart';
import 'package:flutter_bloc_project/data/wishlist_items.dart';
import 'package:flutter_bloc_project/features/home/models/home_product_data_model.dart';

part 'homes_event.dart';
part 'homes_state.dart';

class HomesBloc extends Bloc<HomesEvent, HomesState> {
  HomesBloc() : super(HomesInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeProductWhishlistButtonClickedEvent>(
        homeProductWhishlistButtonClickedEvent);
    on<HomeProductCartButtonClickedEvent>(homeProductCartButtonClickedEvent);
    on<HomeWishlistButtonNavigateEvent>(homeWishlistButtonNavigateEvent);
    on<HomeCartButtonNavigateEvent>(homeCartButtonNavigateEvent);
    on<HomeCardProdukButtonNavigateEvent>(homeCardProdukButtonNavigateEvent);
    on<HomeSearchProductEvent>(homeSearchProductEvent);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomesState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(const Duration(seconds: 3));
    emit(
      HomeLoadedSuccessState(
        products: GroceryData.groceryProducts
            .map((index) => ProductDataModel(
                  id: index['id'],
                  name: index['name'],
                  description: index['description'],
                  price: index['price'],
                  imageUrl: index['imageUrl'],
                ))
            .toList(),
      ),
    );
  }

  FutureOr<void> homeProductWhishlistButtonClickedEvent(
      HomeProductWhishlistButtonClickedEvent event, Emitter<HomesState> emit) {
    print("Wishlist Product Clicked");

    wishlistItems.add(event.clickedProduct);
    emit(HomeProductItemWishlistedActionState());
  }

  FutureOr<void> homeProductCartButtonClickedEvent(
      Object event, Emitter<HomesState> emit) {
    print("Cart Product Clicked");
    try {
      if (event is HomeProductCartButtonClickedEvent) {
        cartItems.add(event.clickedProduct);
      } else {
        throw ArgumentError('Invalid event type: ${event.runtimeType}');
      }
    } catch (e) {
      print(e.toString());
    }
    emit(HomeProductItemChartedActionState());
  }

  FutureOr<void> homeWishlistButtonNavigateEvent(
      HomeWishlistButtonNavigateEvent event, Emitter<HomesState> emit) {
    print("Wishlist Navigate Clicked");
    emit(HomeNavigateToWishlistPageActionState());
  }

  FutureOr<void> homeCartButtonNavigateEvent(
      HomeCartButtonNavigateEvent event, Emitter<HomesState> emit) {
    print("Cart Navigate Clicked");
    emit(HomeNavigateToCartPageActionState());
  }

  FutureOr<void> homeCardProdukButtonNavigateEvent(
      HomeCardProdukButtonNavigateEvent event, Emitter<HomesState> emit) {
    print("Card Product Clicked");
    emit(HomeNavigateToDetailProductPageActionState(event.clickedProduct));
  }

  Future<void> homeSearchProductEvent(
      HomeSearchProductEvent event, Emitter<HomesState> emit) async {
    if (event.query.isEmpty) {
      // Check if input is empty
      // Emit the initial state with all products loaded
      emit(HomeLoadedSuccessState(
        products: GroceryData.groceryProducts
            .map((index) => ProductDataModel(
                  id: index['id'],
                  name: index['name'],
                  description: index['description'],
                  price: index['price'],
                  imageUrl: index['imageUrl'],
                ))
            .toList(),
      ));
    } else if (state is HomeLoadedSuccessState) {
      final HomeLoadedSuccessState currentState =
          state as HomeLoadedSuccessState;
      final List<ProductDataModel> searchResults = currentState.products
          .where((product) =>
              product.name.toLowerCase().contains(event.query.toLowerCase()))
          .toList();
      if (searchResults.isEmpty) {
        //emit(HomeNoSearchResultState());
      } else {
        emit(HomeLoadedSuccessState(products: searchResults));
      }
    }
  }
}
