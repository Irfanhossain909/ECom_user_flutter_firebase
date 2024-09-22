
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/foundation.dart';

import '../db/db_helper.dart';

class FirebaseAuthProvider with ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  User? get currentUser => _auth.currentUser;

  Future<bool> loginAdmin(String email, String password) async{
    final credenchial = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return DbHelper.isAdmin(credenchial.user!.uid);// take uid for matching login uid!!!

  }
  Future<void> logout() => _auth.signOut();
}