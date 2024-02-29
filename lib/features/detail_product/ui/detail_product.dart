import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc_project/features/home/models/home_product_data_model.dart';
import 'package:flutter_bloc_project/theme/theme.dart';
import 'package:qr_flutter/qr_flutter.dart';

class DetailProduct extends StatelessWidget {
  final ProductDataModel productDataModel;
  const DetailProduct({super.key, required this.productDataModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Detail Products',
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
      body: Container(
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
                  // Positioned.fill(
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       gradient: LinearGradient(
                  //         begin: Alignment.bottomCenter,
                  //         end: Alignment.topCenter,
                  //         colors: [
                  //           titleColor
                  //               .withOpacity(0.12), // Adjust opacity as needed
                  //           Colors.transparent,
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Favorite icon
                  Positioned(
                    top: 20,
                    right: 24,
                    child: IconButton(
                      onPressed: () {
                        // homeBloc.add(HomeProductWhishlistButtonClickedEvent(
                        //     clickedProduct: productDataModel));
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
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productDataModel.description,
                        style: subtitleTextStyle.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        productDataModel.name,
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
                      const SizedBox(
                        height: 24,
                      ),
                      Center(
                        child: QrImageView(
                          data: productDataModel.name,
                          version: QrVersions.auto,
                          size: 200.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    elevation: 4, // Tinggi bayangan
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(50), // Atur radius sudut
                    ),
                    shadowColor: shadowPrimaryColor,
                    minimumSize: const Size.fromHeight(50) // ShShadow spread
                    ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  child: Text(
                    'Add to Cart', // Teks tombol
                    style: textButtonPrimaryStyle.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
