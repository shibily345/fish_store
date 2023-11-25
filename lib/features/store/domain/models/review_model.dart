import 'package:betta_store/features/store/domain/models/user_model.dart';

class Review {
  List<ReviewModel>? reviews;

  Review({this.reviews});

  Review.fromJson(Map<String, dynamic> json) {
    if (json['reviews'] != null) {
      reviews = <ReviewModel>[];
      json['reviews'].forEach((v) {
        reviews!.add(new ReviewModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReviewModel {
  int? id;
  int? userId;
  int? productId;
  String? img;
  double? rating;
  String? comment;
  String? createdAt;
  String? updatedAt;
  UserModel? user;

  ReviewModel(
      {this.id,
      this.userId,
      this.productId,
      this.img,
      this.rating,
      this.comment,
      this.createdAt,
      this.updatedAt,
      this.user});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'];
    img = json['img'];
    rating = double.parse(json['rating'].toString());
    comment = json['comment'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new UserModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['product_id'] = this.productId;
    data['img'] = this.img;
    data['rating'] = this.rating;
    data['comment'] = this.comment;

    return data;
  }
}
