class AddressModel {
  String streetLine;
  String city;
  String zipCode;

  AddressModel({
    required this.streetLine,
    required this.city,
    required this.zipCode,
  });
  Map<String, dynamic> toMap() {
    return {
      'streetLine': streetLine,
      'city': city,
      'zipCode': zipCode,};
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      streetLine: map['streetLine'] ?? '',
      city: map['city'] ?? '',
      zipCode: map['zipCode'] ?? '',
    );
  }
}
