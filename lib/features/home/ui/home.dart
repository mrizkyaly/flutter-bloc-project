import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_project/features/cart/ui/cart.dart';
import 'package:flutter_bloc_project/features/home/bloc/homes_bloc.dart';
import 'package:flutter_bloc_project/features/home/ui/product_tile.widget.dart';
import 'package:flutter_bloc_project/features/wishlist/ui/wishlist.dart';
import 'package:flutter_bloc_project/theme/theme.dart';

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

  // BURRON NOT ACTIVE FILTER
  Widget buttonNotActiveFilter(String name) {
    return ElevatedButton(
      onPressed: () {
        // Implement filter logic for "All"
      },
      style: ElevatedButton.styleFrom(
        elevation: 0, // Set elevation to 0 to remove shadow
        backgroundColor: Colors.white, // Set background color to pure white
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          side: BorderSide(
              width: 1, color: borderColor), // Border width and color
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 12,
        ),
        child: Text(
          name, // Button text
          style: inputTextStyle.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // BUTTON ACTIVE FILTER
  Widget buttonActiveFilter(String name) {
    return ElevatedButton(
      onPressed: () {
        // Implement filter logic for "All"
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        elevation: 4, // Tinggi bayangan
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50), // Atur radius sudut
        ),
        shadowColor: shadowPrimaryColor, // ShShadow spread
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 12,
        ),
        child: Text(
          name, // Teks tombol
          style: textButtonPrimaryStyle.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // SEARCH FORM INPUT
  Widget searchInput() {
    return Container(
      height: 50,
      margin: const EdgeInsets.only(
        top: 20,
        left: 24,
        right: 24,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: borderColor, // Border color
          width: 1.0, // Border width
        ),
        borderRadius: BorderRadius.circular(
          50,
        ),
      ),
      child: Center(
        child: Row(
          children: [
            Icon(
              Icons.search,
              color: iconColor,
            ),
            const SizedBox(
              width: 18,
            ),
            Expanded(
              child: TextFormField(
                style: inputTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
                decoration: InputDecoration.collapsed(
                  hintText: 'Your Email Address',
                  hintStyle: inputTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomesBloc, HomesState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Cart()));
        } else if (state is HomeNavigateToWishlistPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Wishlist()));
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
              child: CircularProgressIndicator(),
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
                  margin: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      searchInput(),
                      const SizedBox(height: 20),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              // Filter buttons
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: buttonActiveFilter('All'),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: buttonNotActiveFilter('Discount'),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: buttonNotActiveFilter('Sales'),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: buttonNotActiveFilter('Running'),
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
                                  return ProductTileWidget(
                                    homeBloc: homeBloc,
                                    productDataModel:
                                        successState.products[index],
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
