import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_user/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/foundation.dart';

import '../db/db_helper.dart';

class FirebaseAuthProvider with ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  UserModel? userModel;
  User? get currentUser => _auth.currentUser;


  getUserModel() {
    DbHelper.getUser(currentUser!.uid).listen((snapshot){
      userModel = UserModel.fromMap(snapshot.data()!);
    });
  }

  Future<void> loginUser(String email, String password) async {
    final credenchial = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> registerUser(String email, String password) async {
    final credenchial = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return DbHelper.addNewUser(UserModel(
      uid: credenchial.user!.uid,
      email: email,
      creationTime: Timestamp.fromDate(
          credenchial.user!.metadata.creationTime!),)); //Timestamp.fromDate() use for convert database timestam,
  }

  Future<void> logout() => _auth.signOut();
}
