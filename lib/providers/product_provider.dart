



import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import '../db/db_helper.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';

class ProductProvider with ChangeNotifier {
  List<CategoryModel> categoryList = [];
  List<ProductModel> productList = [];


  getAllCategory(){
    DbHelper.getAllCategoryList().listen((snapshot){
      categoryList = List.generate(snapshot.docs.length, (index) =>
      CategoryModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }

  getAllProducts(){
    DbHelper.getAllProducts().listen((snapshot){
      productList = List.generate(snapshot.docs.length, (index) =>
          ProductModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }
  ProductModel getProductFromListById(String id){
    return productList.firstWhere((product)=> product.id == id);//going to match both id by using this line,
  }

  Future<void> updateSingleProductField(String id, String field, dynamic value) {
    return DbHelper.updateSingleProductField(id, field, value);
  }


  Future<String> uploadImageRetSrorage(String localPath) async{
    final imageName = 'Image_${DateTime.now().millisecondsSinceEpoch}';// create image name on storage.
    final imageRef = FirebaseStorage.instance.ref().child('Images/$imageName');//create Image folder in storage and named image file,
    final task = imageRef.putFile(File(localPath));
    final snapshot = await task.whenComplete((){}); //whenComplete((){}) methord call after file uploaded.
    return snapshot.ref.getDownloadURL();
  }
}