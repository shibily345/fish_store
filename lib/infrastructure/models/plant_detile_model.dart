class Plantinfo {
  int? _totalSize;
  int? _typeId;
  int? _offset;
  late List<PlantModel> _plants;
  List<PlantModel> get plants => _plants;
  Plantinfo(
      {required totalSize, required typeId, required offset, required Plants}) {
    this._totalSize = totalSize;
    this._typeId = typeId;
    this._offset = offset;
    this._plants = Plants;
  }

  Plantinfo.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    _typeId = json['type_id'];
    _offset = json['offset'];
    if (json['products'] != null) {
      _plants = <PlantModel>[];
      json['products'].forEach((v) {
        _plants.add(PlantModel.fromJson(v));
      });
    }
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['total_size'] = this.totalSize;
  //   data['type_id'] = this.typeId;
  //   data['offset'] = this.offset;
  //   if (this.products != null) {
  //     data['products'] = this.products!.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }
}

class PlantModel {
  int? id;
  String? name;
  String? description;
  int? price;
  int? stars;
  String? img;
  String? location;
  String? createdAt;
  String? updatedAt;
  int? typeId;

  PlantModel(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.stars,
      this.img,
      this.location,
      this.createdAt,
      this.updatedAt,
      this.typeId});

  PlantModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    stars = json['stars'];
    img = json['img'];
    location = json['location'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    typeId = json['type_id'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['name'] = this.name;
  //   data['description'] = this.description;
  //   data['price'] = this.price;
  //   data['stars'] = this.stars;
  //   data['img'] = this.img;
  //   data['location'] = this.location;
  //   data['created_at'] = this.createdAt;
  //   data['updated_at'] = this.updatedAt;
  //   data['type_id'] = this.typeId;
  //   return data;
  // }
}
