

import 'package:ecom_user/models/user_model.dart';

class RattingModel {
  UserModel userModer;
  String productId;
  double ratting;

  RattingModel({
    required this.userModer,
    required this.productId,
    required this.ratting,
  });

  Map<String, dynamic> toMap() {
    return {
      'userModer': userModer.toMap(),
      'productId': productId,
      'ratting': ratting,
    };
  }

  factory RattingModel.fromMap(Map<String, dynamic> map) {
    return RattingModel(
      userModer: UserModel.fromMap(map['userModer']),
      productId: map['productId'] ?? '',
      ratting: map['ratting'] ?? 0.0,
    );
  }

}