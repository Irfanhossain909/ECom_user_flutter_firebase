import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_user/db/db_helper.dart';
import 'package:ecom_user/models/order_model.dart';
import 'package:ecom_user/models/order_settings_model.dart';
import 'package:flutter/foundation.dart';

class OrderProvider with ChangeNotifier {
  OrderSettingModel settingsModel = OrderSettingModel();
  
  
  
  Future<void> saveOrder(OrderModel order) {
    return DbHelper.addNewOrder(order);
  }


  getOrderConstants() {
    DbHelper.getAllOrderConstants().listen((snapshot) {
      settingsModel = OrderSettingModel.fromMap(snapshot.data()!);
      notifyListeners();
    });
  }
  

  num getDiscountAmountOnSubtotal(num subtotal) {
    return (subtotal * settingsModel.discount) / 100;
  }

  num getSubTotalAtterDiscount(num subtotal) {
    return subtotal - getDiscountAmountOnSubtotal(subtotal);
  }

  num getVatAmount(num subtotal) {
    final subTotalAfterDiscount = getSubTotalAtterDiscount(subtotal);
    return (subTotalAfterDiscount * settingsModel.vat) / 100;
  }

  num getGrandTotal(num subtotal) {
    return (subtotal - getDiscountAmountOnSubtotal(subtotal)) + getVatAmount(subtotal) + settingsModel.deliveryCharge;
  }
}
