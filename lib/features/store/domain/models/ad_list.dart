class AdListModel {
  int? id;
  int? userId;
  int? productId;
  String? img;
  String? data;
  String? createdAt;
  String? updatedAt;

  AdListModel({
    this.id,
    this.userId,
    this.productId,
    this.img,
    this.data,
    this.createdAt,
    this.updatedAt,
  });
  List<AdListModel> reviews = [];
  AdListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'];
    img = json['img'];
    data = json['data'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'user_id': userId,
      'product_id': productId,
      'img': img,
      'data': this.data,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
    return data;
  }

  /// Extract a list of image URLs from a list of AdListModel instances.
  static List<String> extractImageUrls(List<AdListModel> adList) {
    return adList.map((ad) => ad.img!).toList();
  }
}
