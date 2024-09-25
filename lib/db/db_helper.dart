
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_user/models/cart_model.dart';
import 'package:ecom_user/models/order_model.dart';
import 'package:ecom_user/models/user_model.dart';

import '../models/ratting_model.dart';

class DbHelper {
  DbHelper._(); // for private DbHelper class.thits no one can create this class object.
  static final _db =
      FirebaseFirestore.instance; //Firebase database object creating,
  static const String _collectionUser = 'Users';
  static const String _collectionCategory = 'Categories';
  static const String _collectionProduct = 'Products';
  static const String _collectionCart = 'MyCart';
  static const String _collectionOrderSettings = 'OrderSettings';
  static const String _collectionOrder = 'Orders';
  static const String _collectionRatings = 'Ratings';
  static const String _documentOrderConstants = 'OrderConstants';

  static Future<void>addNewUser(UserModel user) {
    return _db.collection(_collectionUser)//create a collection in database,
        .doc(user.uid)//create document in database,
        .set(user.toMap());//set user as a Map to calling toMap function,
  }

  static Future<void>addToCart(CartModel cart, String uid) {
    return _db.collection(_collectionUser)//collection select
        .doc(uid)//in collection document select
        .collection(_collectionCart)//in document new collection add
        .doc(cart.productId)//new colection id == cart.productId
        .set(cart.toMap());// set to a map
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllCategoryList() =>
      _db.collection(_collectionCategory).orderBy('name').snapshots();


  static Stream<DocumentSnapshot<Map<String, dynamic>>> getAllOrderConstants() =>
      _db.collection(_collectionOrderSettings).doc(_documentOrderConstants).snapshots();

  static Stream<DocumentSnapshot<Map<String, dynamic>>> getUser(String uid) =>
      _db.collection(_collectionUser).doc(uid).snapshots();


  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllProducts() =>
      _db.collection(_collectionProduct).where('available', isEqualTo: true).snapshots();//use where('available', isEqualTo: true) for getting only avilable product from firebase,


  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllCartItemsByUser(String uid) =>
      _db.collection(_collectionUser)
      .doc(uid)
      .collection(_collectionCart)
      .snapshots();

  static Future<void>removeFromCart(String pid, String uid) {
    return _db.collection(_collectionUser)
        .doc(uid)
        .collection(_collectionCart)
        .doc(pid).delete();

  }


  static Future<void> clearCart(String uid, List<CartModel> cartList) {
    final wb = _db.batch();
    for(final cart in cartList) {
      final cartDoc = _db.collection(_collectionUser)
          .doc(uid)
          .collection(_collectionCart)
          .doc(cart.productId);
      wb.delete(cartDoc);
    }
    return wb.commit();
  }


  static Future<void> addNewOrder(OrderModel order) async{
    final wb = _db.batch();//use this line _db.batch() to do multiple query in database,
    final orderDoc = _db.collection(_collectionOrder).doc(order.orderId);
    wb.set(orderDoc, order.toMap());
    final userDoc = _db.collection(_collectionUser).doc(order.userModel.uid);
    wb.update(userDoc, {'address' : order.userModel.address!.toMap()});
    for(final cart in order.cartList) {
      final productSnapshot = await _db.collection(_collectionProduct).
      doc(cart.productId).get();

      final prevStock = productSnapshot.data()!['stock'];
      final newStock = prevStock - cart.quantity;
      final productDoc = _db.collection(_collectionProduct).doc(cart.productId);
      wb.update(productDoc, {'stock' : newStock});
    }
    return wb.commit();
  }

  static Future<void>addRating(RattingModel ratingModel) async{
    final wb = _db.batch();
    final ratingDoc = _db.collection(_collectionProduct)//go _collectionProduct
        .doc(ratingModel.productId)//then go ratingModel.productId
        .collection(_collectionRatings)// create new _collectionRatings
        .doc(ratingModel.userModer.uid);//uid set new doc user id
    wb.set(ratingDoc, ratingModel.toMap());
    return wb.commit();
  }



  static Future<QuerySnapshot<Map<String, dynamic>>> getRatingsByProduct(String pid) {
    return _db.collection(_collectionProduct)
        .doc(pid)
        .collection(_collectionRatings).get();

  }
  static Future<void>updateProductAvgRating(String pid, double avgRating) {
    return _db.collection(_collectionProduct)
        .doc(pid)
        .update({'avgRatting' : avgRating});
  }



  static Future<void> updateCartQuantity (String pid, String uid, num updatedQuantity) {
    return _db.collection(_collectionUser)
        .doc(uid)
        .collection(_collectionCart)
        .doc(pid)
        .update({'quantity' : updatedQuantity});
  }

  static Future<void> updateSingleProductField(String id, String field, dynamic value) {
    return _db.collection(_collectionProduct) //created this query methord that i can edit any field in details page,
        .doc(id)
        .update({field: value});
  }
}
