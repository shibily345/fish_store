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
    this._totalSize = totalSize;
    this._typeId = typeId;
    this._offset = offset;
    this._products = products;
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
  int? stars;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['breeder'] = this.breeder;
    data['seller_id'] = this.sellerId;
    data['description'] = this.description;
    data['price'] = this.price;
    data['malePrice'] = this.malePrice;
    data['femalePrice'] = this.femalePrice;
    data['stars'] = this.stars;
    data['img'] = this.img;
    data['video'] = this.video;
    data['location'] = this.location;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['type_id'] = this.typeId;
    return data;
  }
}
