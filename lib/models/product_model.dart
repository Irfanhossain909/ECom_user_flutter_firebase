

import 'category_model.dart';

class ProductModel{
  String? id;
  String productName;
  CategoryModel categoryModel;
  num price;
  num stock;
  String description;
  String imageUrl;
  bool available;
  double avgRatting;
  int discountPercent;

  ProductModel(
      {this.id,
      required this.productName,
      required this.categoryModel,
      required this.price,
      required this.stock,
      required this.description,
      required this.imageUrl,
      this.available = true,
      this.avgRatting = 0.0,
      this.discountPercent = 0
      });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productName': productName,
      'categoryModel': categoryModel.toMap(),
      'price': price,
      'stock': stock,
      'description': description,
      'imageUrl': imageUrl,
      'available': available,
      'avgRatting': avgRatting,
      'discountPercent': discountPercent,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      productName: map['productName'] ?? '',
      categoryModel: CategoryModel.fromMap(map['categoryModel']),
      price: map['price'] ?? 0,
      stock: map['stock'] ?? 0,
      description: map['description'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      available: map['available'] ?? true,
      avgRatting: map['avgRatting'] ?? 0.0,
      discountPercent: map['discountPercent'] ?? 0,
    );
  }
  num get priceAfterDiscount{
    if(discountPercent == 0) return price;
    return price - ((price * discountPercent) / 100);
  }

}