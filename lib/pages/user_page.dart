import 'package:ecom_user/models/user_model.dart';
import 'package:flutter/material.dart';

class UserListPage extends StatelessWidget {
  static const String routeName = '/userlist';
  const UserListPage({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
      ),
    );
  }
}
