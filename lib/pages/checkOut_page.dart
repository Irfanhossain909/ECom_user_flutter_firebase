import 'package:ecom_user/customwidgets/header_view.dart';
import 'package:ecom_user/providers/auth_provider.dart';
import 'package:ecom_user/providers/cart_provider.dart';
import 'package:ecom_user/providers/order_provider.dart';
import 'package:ecom_user/utils/constants.dart';
import 'package:ecom_user/utils/widgets_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatefulWidget {
  static const String routeName = '/checkout';

  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  late CartProvider cartProvider;
  late OrderProvider orderProvider;
  late FirebaseAuthProvider authProvider;
  final _addressLineController = TextEditingController();
  final _zipController = TextEditingController();
  String? city;

  @override
  void didChangeDependencies() {
    cartProvider = Provider.of<CartProvider>(context);
    orderProvider = Provider.of<OrderProvider>(context);
    authProvider = Provider.of<FirebaseAuthProvider>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 2, right: 2),
        child: BottomAppBar(
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          child: ElevatedButton(
            onPressed: _saveOrder,
            child: Text('Place Order'),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: [
          const HeaderView(title: 'CHECKOUT ITEMS'),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: cartProvider.cartList
                    .map((cart) => ListTile(
                          title: Text(
                            cart.productName,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.blue,
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 4, left: 4),
                            child: Text(
                              '${cart.quantity}x${cart.price}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.orange,
                              ),
                            ),
                          ),
                          trailing: Text(
                            '$currency${cart.priceWithQuantity}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              color: Colors.green,
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
          const HeaderView(title: 'ORDER SUMMERY'),
          Card(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'SubTotal ',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        '$currency${cartProvider.getCartSubTotal}',
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Discount  (${(orderProvider.settingsModel.discount)})%',
                        style: TextStyle(fontSize: 16, color: Colors.red),
                      ),
                      Text(
                        '- $currency${orderProvider.getDiscountAmountOnSubtotal(cartProvider.getCartSubTotal)}',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 1.5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Subtotal : ',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            '$currency${cartProvider.getCartSubTotal - orderProvider.settingsModel.deliveryCharge}',
                            style: TextStyle(
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Delivery Charge ',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        '+ $currency${orderProvider.settingsModel.deliveryCharge}',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Vat  (${orderProvider.settingsModel.vat})%',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        '+ $currency${orderProvider.getVatAmount(cartProvider.getCartSubTotal)}',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 1.5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Grand Total  : $currency${cartProvider.getCartSubTotal - orderProvider.settingsModel.deliveryCharge + orderProvider.settingsModel.deliveryCharge + orderProvider.settingsModel.vat}',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          HeaderView(title: 'Delivery Address'),
          _deliveryAddressSection(),
        ],
      ),
    );
  }

  Widget _deliveryAddressSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _addressLineController,
              decoration: const InputDecoration(
                hintText: 'Address Line',
              ),
            ),
            TextField(
              controller: _zipController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Zip Code',
              ),
            ),
            DropdownButton<String>(
              hint: const Text('Select City'),
              isExpanded: true,
              items: cities
                  .map((city) => DropdownMenuItem<String>(
                        value: city,
                        child: Text(city),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  city = value;
                });
              },
            )
          ],
        ),
      ),
    );
  }

  void _saveOrder() {
    if(_addressLineController.text.isEmpty){
      showMsg(context, 'Address Lise in empty');
      return;
    }
    if(_zipController.text.isEmpty){
      showMsg(context, 'Zip Code in empty');
      return;
    }
    if(city == null){
      showMsg(context, 'City is empty');
      return;
    }

    final order =
  }
}
