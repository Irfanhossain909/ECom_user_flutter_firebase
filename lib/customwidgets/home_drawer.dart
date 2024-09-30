import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom_user/customwidgets/product_grid_item.dart';
import 'package:ecom_user/pages/launcher_page.dart';
import 'package:ecom_user/pages/login_page.dart';
import 'package:ecom_user/pages/order_page.dart';
import 'package:ecom_user/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import '../pages/cart_page.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            width: double.infinity,
            height: 250.0,
            color: Colors.green,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.red.shade400,
                        shape: BoxShape.circle,
                      )),
                ),

              ],
            ),
          ),
          Column(
           children: [
             Card(
               child: ListTile(
                 onTap: (){
                   Navigator.pop(context);
                 },
                 title: const Text('Profile'),
                 leading: const Icon(Icons.person),
               ),
             ),
             Card(
               child: ListTile(
                 onTap: (){
                   Navigator.pop(context);
                   Navigator.pushNamed(context,CartPage.routeName);
                 },
                 title: const Text('My Cart'),
                 leading: const Icon(Icons.shopping_cart_checkout_rounded),
               ),
             ),
             Card(
               child: ListTile(
                 onTap: (){
                   Navigator.pop(context);
                   Navigator.pushNamed(context, OrderPage.routeName);
                 },
                 title: const Text('My Orders'),
                 leading: const Icon(Icons.monetization_on_rounded),
               ),
             ),
             Card(
               child: ListTile(
                 onTap: (){
                   Navigator.pop(context);
                 },
                 title: const Text('Setting'),
                 leading: const Icon(Icons.settings),
               ),
             ),
             Card(
               child: ListTile(
                 onTap: (){
                   Navigator.pop(context);
                   context.read<FirebaseAuthProvider>()
                   .logout().then((_){
                     Navigator.pushReplacementNamed(context, LauncherPage.routeName);
                   });
                 },
                 title: const Text('Logout'),
                 leading: const Icon(Icons.logout),
               ),
             ),


           ],
         ),
        ],
      ),
    );
  }
}
