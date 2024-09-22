
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _errorMsg = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 48.0, vertical: 4.0),
                child: TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'is empty';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 48.0, vertical: 4.0),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                    prefixIcon: Icon(Icons.password),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'is empty';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _loginAdmin,
                child: const Text('Login as admin'),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                _errorMsg,
                style: const TextStyle(fontSize: 18.0, color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _loginAdmin() async{ //use async for dataloading and for future methord also use await for wait to get load the data.
    // validator function validate the email and pass.
    if(_formKey.currentState!.validate()){//_formKey.currentState!.validate() use for valodate the feiled,
      final email = _emailController.text;
      final password = _passwordController.text;

      EasyLoading.show(status: 'Pleace Wait...'); // use easy loading for reduce waiting time for use, and show a loading bar.
      try{



      } on FirebaseAuthException catch(error) { //Use FirebaseAuthException to catch spesefic error.
        setState(() {
          _errorMsg = 'Login Failed :${error.message}';
        });
      }finally { // use finally block to confirm execute this block,in here use for Easyloading.dismiss,
        EasyLoading.dismiss();
      }

    }
  }
}
