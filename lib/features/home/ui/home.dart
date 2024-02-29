import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_project/features/cart/ui/cart.dart';
import 'package:flutter_bloc_project/features/detail_product/ui/detail_product.dart';
import 'package:flutter_bloc_project/features/home/bloc/homes_bloc.dart';
import 'package:flutter_bloc_project/features/home/ui/product_tile.widget.dart';
import 'package:flutter_bloc_project/features/wishlist/ui/wishlist.dart';
import 'package:flutter_bloc_project/theme/theme.dart';
import 'package:flutter_bloc_project/widgets/button_filter.dart';
import 'package:flutter_bloc_project/widgets/search_input.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  final HomesBloc homeBloc = HomesBloc();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomesBloc, HomesState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Cart()));
        } else if (state is HomeNavigateToWishlistPageActionState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Wishlist()));
        } else if (state is HomeNavigateToDetailProductPageActionState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailProduct(
                productDataModel: state.clickedProduct,
              ),
            ),
          );
        } else if (state is HomeProductItemChartedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                'Item Has Add to Cart',
              ),
            ),
          );
        } else if (state is HomeProductItemWishlistedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                'Item Has Add to WIshlist',
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const Scaffold(
                body: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xffE21836)),
              ),
            ));
          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.transparent,
                leading: Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: IconButton(
                    onPressed: () {
                      homeBloc.add(HomeWishlistButtonNavigateEvent());
                    },
                    icon: Icon(
                      Icons.favorite_border_outlined,
                      color: iconColor,
                    ),
                  ),
                ),
                title: Image.asset('assets/logo-nb.png'),
                centerTitle: true,
                actions: [
                  Container(
                    margin: const EdgeInsets.only(right: 24),
                    child: IconButton(
                      onPressed: () {
                        homeBloc.add(HomeCartButtonNavigateEvent());
                      },
                      icon: Icon(
                        Icons.shopping_bag_outlined,
                        color: iconColor,
                      ),
                    ),
                  ),
                ],
                elevation: 0,
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(
                      10.0), // Set the preferred size for the bottom border
                  child: Container(
                    color: borderColor,
                    height: 1.0, // Height of the bottom border
                  ),
                ),
              ),
              body: Expanded(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      SearchInput(homesBloc: homeBloc),
                      const SizedBox(height: 20),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ButtonFilter(
                                      homesBloc: homeBloc,
                                      name: 'All',
                                      type: 'All',
                                      onPress: () {
                                        homeBloc.add(HomeFilteredProductEvent(
                                          filterType: 'All',
                                        ));
                                      },
                                    ),
                                    ButtonFilter(
                                      homesBloc: homeBloc,
                                      name: 'Men',
                                      type: 'Mens',
                                      onPress: () {
                                        homeBloc.add(HomeFilteredProductEvent(
                                          filterType: 'Mens',
                                        ));
                                      },
                                    ),
                                    ButtonFilter(
                                      homesBloc: homeBloc,
                                      name: 'Women',
                                      type: 'Womens',
                                      onPress: () {
                                        homeBloc.add(HomeFilteredProductEvent(
                                          filterType: 'Womens',
                                        ));
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              // ListView.builder for displaying products
                              ListView.builder(
                                shrinkWrap: true,
                                physics:
                                    const NeverScrollableScrollPhysics(), // Disable scrolling of ListView.builder
                                itemCount: successState.products.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      homeBloc.add(
                                          HomeCardProdukButtonNavigateEvent(
                                              clickedProduct: successState
                                                  .products[index]));
                                    },
                                    child: ProductTileWidget(
                                      homeBloc: homeBloc,
                                      productDataModel:
                                          successState.products[index],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          case HomeErrorState:
            return const Scaffold(
              body: Center(
                child: Text('Error'),
              ),
            );
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}
