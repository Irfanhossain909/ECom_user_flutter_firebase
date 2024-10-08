import 'package:ecom_user/pages/cart_page.dart';
import 'package:ecom_user/pages/category_page.dart';
import 'package:ecom_user/pages/checkOut_page.dart';
import 'package:ecom_user/pages/launcher_page.dart';
import 'package:ecom_user/pages/login_page.dart';
import 'package:ecom_user/pages/order_page.dart';
import 'package:ecom_user/pages/product_details.dart';
import 'package:ecom_user/pages/user_page.dart';
import 'package:ecom_user/pages/view_product.dart';
import 'package:ecom_user/providers/auth_provider.dart';
import 'package:ecom_user/providers/cart_provider.dart';
import 'package:ecom_user/providers/order_provider.dart';
import 'package:ecom_user/providers/product_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'pages/order_success_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(MultiProvider(
      providers: [// only provider added
        ChangeNotifierProvider(create: (context) => FirebaseAuthProvider()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => OrderProvider()),
      ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      builder: EasyLoading.init(),
      initialRoute: LauncherPage.routeName,
      routes: {
        LauncherPage.routeName : (context) => const LauncherPage(),
        LoginPage.routeName : (context) => const LoginPage(),
        CategoryPage.routeName : (context) => const CategoryPage(),
        ViewProductPage.routeName : (context) => const ViewProductPage(),
        OrderPage.routeName : (context) => const OrderPage(),
        ProductDetailsPage.routeName : (context) => const ProductDetailsPage(),
        UserListPage.routeName : (context) => const UserListPage(),
        CartPage.routeName : (context) => const CartPage(),
        CheckoutPage.routeName : (context) => const CheckoutPage(),
        OrderSuccessPage.routeName : (context) => const OrderSuccessPage(),
      },
    );
  }
}

