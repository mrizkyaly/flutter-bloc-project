import 'package:flutter/material.dart';
import 'package:flutter_bloc_project/features/home/bloc/homes_bloc.dart';
import 'package:flutter_bloc_project/features/home/models/home_product_data_model.dart';

class ProductTileWidget extends StatelessWidget {
  final ProductDataModel productDataModel;
  final HomesBloc homeBloc;
  const ProductTileWidget(
      {super.key, required this.productDataModel, required this.homeBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.maxFinite,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(productDataModel.imageUrl),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            productDataModel.name,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(productDataModel.description),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$" + productDataModel.price.toString(),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      homeBloc.add(HomeProductWhishlistButtonClickedEvent(
                          clickedProduct: productDataModel));
                    },
                    icon: Icon(Icons.favorite),
                  ),
                  IconButton(
                    onPressed: () {
                      homeBloc.add(HomeProductCartButtonClickedEvent(
                          clickedProduct: productDataModel));
                      // homeBloc.add(HomeCartButtonNavigateEvent());
                    },
                    icon: Icon(Icons.shopping_bag_outlined),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
