
import 'package:ecom_user/pages/view_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import 'login_page.dart';

class LauncherPage extends StatefulWidget {
  static const String routeName = '/';
  const LauncherPage({super.key});

  @override
  State<LauncherPage> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {
  @override
  void didChangeDependencies() {
    final authProvider = context.read<FirebaseAuthProvider>();
    Future.delayed(const Duration(seconds: 0), (){
      if(authProvider.currentUser != null){
        Navigator.pushReplacementNamed(context, ViewProductPage.routeName);
      }else{
        Navigator.pushReplacementNamed(context, LoginPage.routeName);
      }
    });
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
