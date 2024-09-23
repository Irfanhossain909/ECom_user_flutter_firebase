import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_user/models/cart_model.dart';
import 'package:ecom_user/models/user_model.dart';

class DbHelper {
  DbHelper._(); // for private DbHelper class.thits no one can create this class object.
  static final _db =
      FirebaseFirestore.instance; //Firebase database object creating,
  static const String _collectionUser = 'Users';
  static const String _collectionCategory = 'Categories';
  static const String _collectionProduct = 'Products';
  static const String _collectionCart = 'MyCart';

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
