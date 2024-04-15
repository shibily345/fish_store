class ProductInfoModel {
  int? _totalSize;
  int? _typeId;
  int? _offset;
  late List<ProductModel> _products;
  List<ProductModel> get products => _products;
  ProductInfoModel(
      {required totalSize,
      required typeId,
      required offset,
      required products}) {
    _totalSize = totalSize;
    _typeId = typeId;
    _offset = offset;
    _products = products;
  }

  ProductInfoModel.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    _typeId = json['type_id'];
    _offset = json['offset'];
    if (json['products'] != null) {
      _products = <ProductModel>[];
      json['products'].forEach((v) {
        _products.add(ProductModel.fromJson(v));
      });
    }
  }
}

class ProductModel {
  int? id;
  String? name;
  String? breeder;
  int? sellerId;
  String? description;
  int? price;
  int? malePrice;
  int? femalePrice;
  String? stars;
  int? isRecommended;
  int? people;
  String? img;
  String? video;
  String? location;
  String? createdAt;
  String? updatedAt;
  int? typeId;

  ProductModel(
      {this.id,
      this.name,
      this.breeder,
      this.sellerId,
      this.description,
      this.price,
      this.malePrice,
      this.femalePrice,
      this.stars,
      this.people,
      this.isRecommended,
      this.img,
      this.video,
      this.location,
      this.createdAt,
      this.updatedAt,
      this.typeId});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    breeder = json['breeder'];
    sellerId = json['seller_id'];
    description = json['description'];
    price = json['price'];
    malePrice = json['malePrice'];
    femalePrice = json['femalePrice'];
    stars = json['stars'];
    people = json['people'];
    isRecommended = json['is_recommended'];
    img = json['img'];
    video = json['video'];
    location = json['location'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    typeId = json['type_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['breeder'] = breeder;
    data['seller_id'] = sellerId;
    data['description'] = description;
    data['price'] = price;
    data['malePrice'] = malePrice;
    data['femalePrice'] = femalePrice;
    data['stars'] = stars;
    data['img'] = img;
    data['video'] = video;
    data['location'] = location;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['type_id'] = typeId;
    return data;
  }
}
