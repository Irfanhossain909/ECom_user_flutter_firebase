class CartModel {
  String productId; // Note: This might be a typo and should be productId
  String ProductName;
  String image;
  num price;
  num quantity;

  CartModel({
    required this.productId,
    required this.ProductName,
    required this.image,
    required this.price,
    this.quantity = 1,
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'ProductName': ProductName,
      'image': image,
      'price': price,
      'quantity': quantity,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      productId: map['productId'] ?? '',
      ProductName: map['ProductName'] ?? '',
      image: map['image'] ?? '',
      price: map['price'] ?? 0,
      quantity: map['quantity'] ?? 1,
    );


  }

  num get priceWithQuantity => price * quantity;
}