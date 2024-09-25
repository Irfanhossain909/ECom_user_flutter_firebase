
import 'addredd_model.dart';
import 'cart_model.dart';
import 'date_model.dart';
import 'order_settings_model.dart';
import 'user_model.dart';


class OrderModel {
  String? orderId;
  DateModel dateModel;
  UserModel userModel;
  String orderStatus;
  num grandTotal;
  AddressModel delevaryAddress; // Note: This might be a typo and should be deliveryAddress
  OrderSettingModel orderSettingModel;
  String? additionalInfo;
  List<CartModel> cartList;

  OrderModel({
    this.orderId,
    required this.dateModel,
    required this.userModel,
    required this.orderStatus,
    required this.grandTotal,
    required this.delevaryAddress,
    required this.orderSettingModel,
    this.additionalInfo,
    required this.cartList,
  });

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'dateModel': dateModel.toMap(),
      'userModel': userModel.toMap(),
      'orderStatus': orderStatus,
      'grandTotal': grandTotal,
      'delevaryAddress': delevaryAddress.toMap(),
      'orderSettingModel': orderSettingModel.toMap(),
      'additionalInfo': additionalInfo,
      'cartList': cartList.map((e) => e.toMap()).toList(),
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      orderId: map['orderId'],
      dateModel: DateModel.fromMap(map['dateModel']),
      userModel: UserModel.fromMap(map['userModel']),
      orderStatus: map['orderStatus'] ?? '',
      grandTotal: map['grandTotal'] ?? 0,
      delevaryAddress: AddressModel.fromMap(map['delevaryAddress']),
      orderSettingModel: OrderSettingModel.fromMap(map['orderSettingModel']),
      additionalInfo: map['additionalInfo'],
      cartList: List<CartModel>.from(
          map['cartList']?.map((x) => CartModel.fromMap(x))),
    );
  }
}