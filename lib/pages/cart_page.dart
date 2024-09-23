import 'package:ecom_user/models/user_model.dart';
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  static const String routeName = '/myCart';
  const CartPage({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
      ),
    );
  }
}
