
import 'user_model.dart';


class CommentModel {
  String? id;
  UserModel userModel;
  String productId;
  String comment;
  bool approved;

  CommentModel({
    this.id,
    required this.userModel,
    required this.productId,
    required this.comment,
    this.approved = false,
  });
  Map<String, dynamic> toMap() {
    return {
      'id ' : id,
      'userModel': userModel.toMap(),
      'productId': productId,
      'comment': comment,
      'approved': approved,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      userModel: UserModel.fromMap(map['userModel']),
      id: map['id'],
      productId: map['productId'] ?? '',
      comment: map['comment'] ?? '',
      approved: map['approved'] ?? false,
    );
  }
}