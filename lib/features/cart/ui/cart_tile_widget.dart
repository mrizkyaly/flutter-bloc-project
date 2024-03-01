import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc_project/features/cart/bloc/carts_bloc.dart';
import 'package:flutter_bloc_project/features/home/models/home_product_data_model.dart';
import 'package:flutter_bloc_project/theme/theme.dart';

class CartTileWidget extends StatelessWidget {
  final ProductDataModel productDataModel;
  final CartsBloc cartBloc;
  const CartTileWidget(
      {super.key, required this.productDataModel, required this.cartBloc});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: borderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Image
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Image.network(
                        productDataModel.imageUrl,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Column of text
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productDataModel.description,
                          overflow: TextOverflow.ellipsis,
                          maxLines:
                              2, // Atur jumlah baris maksimum sesuai kebutuhan
                          style: subtitleTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          productDataModel.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines:
                              1, // Atur jumlah baris maksimum sesuai kebutuhan
                          style: titleTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "\$${productDataModel.price}",
                          overflow: TextOverflow.ellipsis,
                          maxLines:
                              1, // Atur jumlah baris maksimum sesuai kebutuhan
                          style: priceTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 24),
                        GestureDetector(
                          onTap: () {
                            cartBloc.add(CartRemoveFromCartEvent(
                                productDataModel: productDataModel));
                          },
                          child: Text(
                            "Remove",
                            overflow: TextOverflow.ellipsis,
                            maxLines:
                                1, // Atur jumlah baris maksimum sesuai kebutuhan
                            style: priceTextStyle.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 12,
                    ),

                    // TextButton(
                    //   onPressed: () {
                    //     cartBloc.add(CartRemoveFromCartEvent(
                    //         productDataModel: productDataModel));
                    //   },
                    //   style: TextButton.styleFrom(
                    //     backgroundColor:
                    //         primaryColor, // Change to your desired background color
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius:
                    //           BorderRadius.circular(50), // Border radius
                    //     ),
                    //   ),
                    //   child: const Padding(
                    //     padding: EdgeInsets.all(4),
                    //     child: Icon(
                    //       Icons.delete,
                    //       color: Colors.white,
                    //       size: 20,
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
