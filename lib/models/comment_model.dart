
import 'user_model.dart';


class CommentModel {
  UserModel userModel;
  String productId;
  String comment;
  bool approved;

  CommentModel({
    required this.userModel,
    required this.productId,
    required this.comment,
    required this.approved,
  });
  Map<String, dynamic> toMap() {
    return {
      'userModel': userModel.toMap(),
      'productId': productId,'comment': comment,
      'approved': approved,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      userModel: UserModel.fromMap(map['userModel']),
      productId: map['productId'] ?? '',
      comment: map['comment'] ?? '',
      approved: map['approved'] ?? false,
    );
  }
}