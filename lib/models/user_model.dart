
import 'package:cloud_firestore/cloud_firestore.dart';

import 'addredd_model.dart';

class UserModel {
  String uid;
  String email;
  Timestamp creationTime;
  String? mobile;
  AddressModel? address;
  String? imageUrl;

  UserModel({
    required this.uid,
    required this.email,
    required this.creationTime,
    this.mobile,
    this.address,
    this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'creationTime': creationTime,
      'mobile': mobile,
      'address': address?.toMap(),
      'imageUrl': imageUrl,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      creationTime: map['creationTime'],mobile: map['mobile'],
      address: map['address'] != null ? AddressModel.fromMap(map['address']) : null,
      imageUrl: map['imageUrl'],
    );
  }
}
