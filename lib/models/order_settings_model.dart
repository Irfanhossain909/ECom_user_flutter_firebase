class OrderSettingModel {
  num deliveryCharge; // Note: This might be a typo and should be deliveryCharge
  int discount;
  int vat;

  OrderSettingModel({
    this.deliveryCharge = 0,
    this.discount = 0,
    this.vat = 0,
  });

  Map<String, dynamic> toMap() {
    return {'deliveryCharge': deliveryCharge,
      'discount': discount,
      'vat': vat,
    };
  }

  factory OrderSettingModel.fromMap(Map<String, dynamic> map) {
    return OrderSettingModel(
      deliveryCharge: map['deliveryCharge'] ?? 0,
      discount: map['discount'] ?? 0,
      vat: map['vat'] ?? 0,
    );
  }
}