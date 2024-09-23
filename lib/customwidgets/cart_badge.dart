

import 'package:ecom_user/pages/cart_page.dart';
import 'package:flutter/material.dart';

class CartBadge extends StatelessWidget {
  const CartBadge({super.key, required this.totalItems});
  final int totalItems;

  @override
  Widget build(BuildContext context) {
    return Stack(
      // clipBehavior: Clip.none,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: () {
              Navigator.pushNamed(context,CartPage.routeName);
            },
            icon: const Icon(Icons.shopping_cart_checkout_rounded,size: 32.0,),
          ),
        ),
        Positioned(
          top: 10,
          left: 10,
          child: Container(
            width: 18,
            height: 18,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: Text(totalItems.toString(),style: TextStyle(color: Colors.yellow,fontWeight: FontWeight.bold),),
          ),
        ),

      ],
    );
  }
}
