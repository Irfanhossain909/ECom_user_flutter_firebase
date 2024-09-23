import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_user/models/user_model.dart';

class DbHelper {
  DbHelper._(); // for private DbHelper class.thits no one can create this class object.
  static final _db =
      FirebaseFirestore.instance; //Firebase database object creating,
  static const String _collectionUser = 'Users';
  static const String _collectionCategory = 'Categories';
  static const String _collectionProduct = 'Products';

  static Future<void>addNewUser(UserModel user) {
    return _db.collection(_collectionUser)//create a collection in database,
        .doc(user.uid)//create document in database,
        .set(user.toMap());//set user as a Map to calling toMap function,
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllCategoryList() =>
      _db.collection(_collectionCategory).orderBy('name').snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllProducts() =>
      _db.collection(_collectionProduct).where('available', isEqualTo: true).snapshots();//use where('available', isEqualTo: true) for getting only avilable product from firebase,

  static Future<void> updateSingleProductField(String id, String field, dynamic value) {
    return _db.collection(_collectionProduct) //created this query methord that i can edit any field in details page,
        .doc(id)
        .update({field: value});
  }
}
