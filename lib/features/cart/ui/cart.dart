import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_project/features/cart/bloc/carts_bloc.dart';
import 'package:flutter_bloc_project/features/cart/ui/cart_tile_widget.dart';
import 'package:flutter_bloc_project/theme/theme.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final CartsBloc cartBloc = CartsBloc();

  @override
  void initState() {
    cartBloc.add(CartInitialEvent());
    super.initState();

    print(cartBloc);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Cart Items',
          style: titleTextStyle.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
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
      body: BlocConsumer<CartsBloc, CartsState>(
        bloc: cartBloc,
        listenWhen: (previous, current) => current is CartActionState,
        buildWhen: (previous, current) => current is! CartActionState,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case CartSuccessState:
              final successState = state as CartSuccessState;

              return Container(
                color: Colors.white,
                child: ListView.builder(
                  itemCount: successState.cartItems.length,
                  itemBuilder: (context, index) {
                    return CartTileWidget(
                      productDataModel: successState.cartItems[index],
                      cartBloc: cartBloc,
                    );
                  },
                ),
              );
            default:
              return SizedBox();
          }
        },
      ),
    );
  }
}
