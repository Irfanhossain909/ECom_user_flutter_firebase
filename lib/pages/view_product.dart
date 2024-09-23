import 'package:ecom_user/customwidgets/cart_badge.dart';
import 'package:ecom_user/customwidgets/home_drawer.dart';
import 'package:ecom_user/customwidgets/product_grid_item.dart';
import 'package:ecom_user/pages/product_details.dart';
import 'package:ecom_user/providers/auth_provider.dart';
import 'package:ecom_user/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';

class ViewProductPage extends StatelessWidget {
  static const String routeName = '/viewproduct';

  const ViewProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProductProvider>().getAllCategory();
    context.read<ProductProvider>().getAllProducts();
    context.read<CartProvider>().getAllCartItemByUSer(
        context.read<FirebaseAuthProvider>().currentUser!.uid);
    return Scaffold(
      drawer: HomeDrawer(),
        appBar: AppBar(
          title: const Text('View Product'),
          actions: [
            Consumer<CartProvider>(
                builder: (context, provider, child) => CartBadge(
                  totalItems: provider.totalItemsInCart,
                ),),
          ],
        ),
        body: Consumer<ProductProvider>(
            builder: (context, provider, child) => GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.70,
                  ),
                  itemCount: provider.productList.length,
                  itemBuilder: (context, index) {
                    final product = provider.productList[index];
                    return ProductGridItem(product: product);
                  },
                )));
  }
}
