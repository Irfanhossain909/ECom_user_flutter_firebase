import 'package:ecom_user/db/db_helper.dart';
import 'package:ecom_user/models/cart_model.dart';
import 'package:ecom_user/models/product_model.dart';
import 'package:flutter/foundation.dart';

class CartProvider with ChangeNotifier {
  List<CartModel> cartList = [];

  bool isProductInCart(String pid) {
    bool tag = false;
    for(final cart in cartList){
      if(cart.productId == pid){
        tag = true;
        break;
      }
    }

    return tag;
  }

  Future<void> addProductToCart(ProductModel product, String uid) {
    final cart = CartModel( //created cartModel object
      productId: product.id!,
      ProductName: product.productName,
      image: product.imageUrl,
      price: product.price,
    );
    return DbHelper.addToCart(cart, uid);
  }
  Future<void>removeFromCart(String pid, String uid) {
    return DbHelper.removeFromCart(pid, uid);
  }

  getAllCartItemByUSer(String uid){
    DbHelper.getAllCartItemsByUser(uid).listen((snapshot){
      cartList = List.generate(snapshot.docs.length, (index) =>
          CartModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }
}
