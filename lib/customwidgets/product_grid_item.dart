import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom_user/models/product_model.dart';
import 'package:ecom_user/pages/product_details.dart';
import 'package:ecom_user/providers/auth_provider.dart';
import 'package:ecom_user/providers/cart_provider.dart';
import 'package:ecom_user/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class ProductGridItem extends StatelessWidget {
  const ProductGridItem({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Stack(children: [
        InkWell(
          onTap: () => Navigator.pushNamed(
            context,
            ProductDetailsPage.routeName,
            arguments: product.id,
          ),
          child: Card(
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 14.0,
                    ),
                    Expanded(
                      child: CachedNetworkImage(
                        width: double.infinity,
                        fit: BoxFit.cover,
                        imageUrl: product.imageUrl,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => const Center(
                          child: Icon(
                            Icons.error,
                          ),
                        ),
                        fadeInDuration: const Duration(milliseconds: 1000),
                        fadeInCurve: Curves.bounceInOut,
                      ),
                    ),
                    Text(
                      product.productName,
                      style: const TextStyle(
                        fontSize:20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Column(
                      children: [
                        RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(
                              text: '$currency${product.priceAfterDiscount}',
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.red,
                              ),
                            )),
                        RichText(
                            text: TextSpan(
                          text: '$currency${product.price}',
                          style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              fontSize: 14,
                              color: Colors.black),
                        ))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Consumer<CartProvider>(
                          builder: (context, provider, child) {
                            final isInCart = provider.isProductInCart(product.id!);
                            return OutlinedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    WidgetStateProperty.all(Colors.red),
                                // Set background color to red
                                foregroundColor:
                                    WidgetStateProperty.all(Colors.yellow),
                                // Set text color to yellow
                                side: WidgetStateProperty.all(const BorderSide(
                                    color: Colors
                                        .white)), // Optional: Set the border color to match the background
                              ),
                              onPressed: () {
                                if (isInCart) {
                                  provider.removeFromCart(
                                      product.id!,
                                      context
                                          .read<FirebaseAuthProvider>()
                                          .currentUser!
                                          .uid);
                                } else {
                                  provider.addProductToCart(
                                      product,
                                      context
                                          .read<FirebaseAuthProvider>()
                                          .currentUser!
                                          .uid);
                                }
                              },
                              child: Text(
                                isInCart ? 'Remove' : 'Add',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            );
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RatingBar.builder(
                              ignoreGestures: true,
                              initialRating: product.avgRatting,
                              minRating: 1.0,
                              direction: Axis.horizontal,
                              itemCount: 5,
                              itemSize: 10,
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (value) {},
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Text(
                                product.avgRatting.toString(),
                                style: const TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.w800),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                if (product.stock == 0)
                  Container(
                    color: Colors.grey.withOpacity(0.8),
                    alignment: Alignment.center,
                    child: const Text(
                      'Stock Out',
                      style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
        if (product.discountPercent > 0)
          Positioned(
            child: Container(
              width: 70,
              height: 70,
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                color: Colors.red.shade400,
                shape: BoxShape.circle,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        '${product.discountPercent}%',
                        style: const TextStyle(
                          color: Colors.yellow,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    'OFF',
                    style: TextStyle(
                      color: Colors.yellow,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ]),
    );
  }
}
