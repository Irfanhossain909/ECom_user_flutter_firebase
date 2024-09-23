import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom_user/models/cart_model.dart';
import 'package:ecom_user/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

class CartItemView extends StatelessWidget {
  const CartItemView(
      {super.key,
      required this.cartModel,
      required this.onAddButtonClicked,
      required this.onRemoveButtonClicked,
      required this.cartRemoveIconClicked});

  final CartModel cartModel;
  final VoidCallback onAddButtonClicked;
  final VoidCallback onRemoveButtonClicked;
  final VoidCallback cartRemoveIconClicked;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      color: Colors.white,
      child: Column(
        children: [
          ListTile(
            leading: CachedNetworkImage(
              width: 70,
              fit: BoxFit.cover,
              imageUrl: cartModel.image,
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
            title: Text(cartModel.ProductName),
            trailing: Text(
              '$currency${cartModel.priceWithQuantity}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  onPressed: onRemoveButtonClicked,
                  icon: const Icon(
                    Icons.remove_circle,
                    color: Colors.red,
                  )),
              Text(
                cartModel.quantity.toString(),
                style: const TextStyle(fontSize: 25.0),
              ),
              IconButton(
                  onPressed: onAddButtonClicked,
                  icon: const Icon(
                    Icons.add_circle,
                    color: Colors.green,
                  )),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                    onPressed: () {
                      cartRemoveIconClicked;
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    )),
              )
            ],
          ),
        ],
      ),
    );
  }
}
