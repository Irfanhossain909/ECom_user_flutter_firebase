import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_user/db/db_helper.dart';
import 'package:ecom_user/models/order_settings_model.dart';
import 'package:flutter/foundation.dart';

class OrderProvider with ChangeNotifier {
  OrderSettingModel settingsModel = OrderSettingModel();


  getOrderConstants() {
    DbHelper.getAllOrderConstants().listen((snapshot) {
      settingsModel = OrderSettingModel.fromMap(snapshot.data()!);
      notifyListeners();
    });
  }

  num getDiscountAmountOnSubtotal(num subtotal) {
    return (subtotal * settingsModel.discount) / 100;
  }

  num getVatAmount (num subtotal) {
    final subTotalAfterDiscount = subtotal - getDiscountAmountOnSubtotal(subtotal);
    return (subTotalAfterDiscount * settingsModel.vat) / 100;
  }
}