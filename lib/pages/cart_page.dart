import 'package:ecom_user/customwidgets/cart_item_view.dart';
import 'package:ecom_user/models/user_model.dart';
import 'package:ecom_user/pages/checkOut_page.dart';
import 'package:ecom_user/providers/auth_provider.dart';
import 'package:ecom_user/providers/cart_provider.dart';
import 'package:ecom_user/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  static const String routeName = '/myCart';

  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        actions: [
          TextButton(
            onPressed: () {
              context.read<CartProvider>().clearCart(
                  context.read<FirebaseAuthProvider>().currentUser!.uid);
            },
            child: const Text('Clear'),
          ),
        ],
      ),
      body: Consumer<CartProvider>(
        builder: (context, provider, child) => Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: provider.cartList.length,
                itemBuilder: (context, index) {
                  final cart = provider.cartList[index];
                  return CartItemView(
                    cartModel: cart,
                    onAddButtonClicked: () {
                      provider.increceCartQuantity(
                          context.read<FirebaseAuthProvider>().currentUser!.uid,
                          cart);
                    },
                    onRemoveButtonClicked: () {
                      provider.decreceCartQuantity(
                          context.read<FirebaseAuthProvider>().currentUser!.uid,
                          cart);
                    },
                    cartRemoveIconClicked: () {
                      provider.removeFromCart(
                          cart.productId,
                          context
                              .read<FirebaseAuthProvider>()
                              .currentUser!
                              .uid);
                    },
                  );
                },
              ),
            ),
            Container(
              width: double.infinity,
              height: 100.0,
              color: Colors.black26,
              child: Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (provider.totalItemsInCart > 0)
                      TextButton(
                        onPressed: () => Navigator.pushNamed(
                            context, CheckoutPage.routeName),
                        child: const Text(
                          'CHECKOUT',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text(
                        'Subtotal: $currency${provider.getCartSubTotal}',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
