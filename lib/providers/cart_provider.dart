import 'package:ecom_user/db/db_helper.dart';
import 'package:ecom_user/models/cart_model.dart';
import 'package:ecom_user/models/product_model.dart';
import 'package:flutter/foundation.dart';

class CartProvider with ChangeNotifier {
  List<CartModel> cartList = [];


  int get totalItemsInCart => cartList.length;

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

  Future<void>increceCartQuantity(String uid, CartModel cart) {
    final newQuantity = cart.quantity + 1;
    return DbHelper.updateCartQuantity(cart.productId, uid, newQuantity);
  }
  Future<void>decreceCartQuantity(String uid, CartModel cart) async{
    if(cart.quantity > 1){
      final newQuantity = cart.quantity - 1;
      await DbHelper.updateCartQuantity(cart.productId, uid, newQuantity);
    }
  }

  num get getCartSubTotal {
    num total = 0;
    for(final cart in cartList){
      total += cart.priceWithQuantity;
  }
  return total;
}

  Future<void> addProductToCart(ProductModel product, String uid) {
    final cart = CartModel( //created cartModel object
      productId: product.id!,
      ProductName: product.productName,
      image: product.imageUrl,
      price: product.priceAfterDiscount,
    );
    return DbHelper.addToCart(cart, uid);
  }
  Future<void>removeFromCart(String pid, String uid) {
    return DbHelper.removeFromCart(pid, uid);
  }

  Future<void>cartRemoveButtonCliced(String pid, String uid) {
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
