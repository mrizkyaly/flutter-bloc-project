import 'package:flutter/material.dart';
import 'package:flutter_bloc_project/features/home/bloc/homes_bloc.dart';
import 'package:flutter_bloc_project/features/home/models/home_product_data_model.dart';
import 'package:flutter_bloc_project/theme/theme.dart';

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
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            height: 300,
            width: double.maxFinite,
            child: Stack(
              children: [
                // Image
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.network(
                      productDataModel.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Linear overlay
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          titleColor
                              .withOpacity(0.12), // Adjust opacity as needed
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                // Favorite icon
                Positioned(
                  top: 20,
                  right: 24,
                  child: IconButton(
                    onPressed: () {
                      homeBloc.add(HomeProductWhishlistButtonClickedEvent(
                          clickedProduct: productDataModel));
                    },
                    icon: Icon(
                      Icons.favorite_border_outlined,
                      color: primaryColor, // Set the color of the icon
                      size: 36, // S
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${productDataModel.description} / ${productDataModel.type}',
                    style: subtitleTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    productDataModel.name,
                    overflow: TextOverflow.ellipsis,
                    style: titleTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "\$${productDataModel.price}",
                    style: priceTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      homeBloc.add(HomeProductCartButtonClickedEvent(
                          clickedProduct: productDataModel));
                      // homeBloc.add(HomeCartButtonNavigateEvent());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      elevation: 4, // Tinggi bayangan
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(50), // Atur radius sudut
                      ),
                      shadowColor: shadowPrimaryColor, // ShShadow spread
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      child: Text(
                        'Add to Cart', // Teks tombol
                        style: textButtonPrimaryStyle.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
