
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom_user/providers/order_provider.dart';
import 'package:ecom_user/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  static const String routeName = '/order';
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<OrderPage> {
  @override
  void didChangeDependencies() {

    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order List'),
      ),
      body: Consumer<OrderProvider>(builder: (context, provider, child) => provider.userOrderList.isEmpty ? 
        const Center(child: Text('No Order'),) :
    ListView.builder(
    itemCount: provider.userOrderList.length,
      itemBuilder: (context, index){
      final order = provider.userOrderList[index];
      return ListTile(
        title: Text(order.orderId!),
        subtitle: Text(order.orderStatus),
        trailing: Text('$currency${order.grandTotal}'),
        leading: CircleAvatar(
          child: CachedNetworkImage(
            width: double.infinity,
            fit: BoxFit.cover,
            imageUrl: order.cartList.first.image,
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
      );
      },
    ),
    ),
    );
  }
}
