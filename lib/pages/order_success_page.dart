import 'package:flutter/material.dart';

class OrderSuccessPage extends StatelessWidget {
  static const String routeName = '/successfull';

  const OrderSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    final orderId = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Invoice'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.done_all_rounded,
              size: 100,
              color: Colors.green,
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              'Order Placed Successfully\nYour order id is: $orderId',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 10.0,
            ),
            OutlinedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
