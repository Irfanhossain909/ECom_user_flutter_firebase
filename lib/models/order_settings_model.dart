class OrderSettingModel {
  num delevaryCharge; // Note: This might be a typo and should be deliveryCharge
  int discount;
  int vat;

  OrderSettingModel({
    this.delevaryCharge = 0,
    this.discount = 0,
    this.vat = 0,
  });

  Map<String, dynamic> toMap() {
    return {'delevaryCharge': delevaryCharge,
      'discount': discount,
      'vat': vat,
    };
  }

  factory OrderSettingModel.fromMap(Map<String, dynamic> map) {
    return OrderSettingModel(
      delevaryCharge: map['delevaryCharge'] ?? 0,
      discount: map['discount'] ?? 0,
      vat: map['vat'] ?? 0,
    );
  }
}