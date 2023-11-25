import 'package:betta_store/features/store/domain/models/products_model.dart';

class CartModel {
  int? id;
  String? name;
  String? breeder;
  double? price;
  String? img;
  int? totquantity;
  int? pquantity;
  int? mquantity;
  int? fquantity;
  bool? isExisted;
  String? time;
  int? typeId;

  CartModel(
      {this.id,
      this.name,
      this.breeder,
      this.price,
      this.img,
      this.totquantity,
      this.pquantity,
      this.mquantity,
      this.fquantity,
      this.isExisted,
      this.time,
      this.typeId});

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    breeder = json['breeder'];
    price = json['price'];
    img = json['img'];
    totquantity = json['totquantity'];
    pquantity = json['pquantity'];
    mquantity = json['mquantity'];
    fquantity = json['fquantity'];
    isExisted = json['isExisted'];
    time = json['time'];
    typeId = json['typeId'];
  }
  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "name": this.name,
      "breeder": this.breeder,
      "price": this.price,
      "img": this.img,
      "totquantity": this.totquantity,
      "pquantity": this.pquantity,
      "mquantity": this.mquantity,
      "fquantity": this.fquantity,
      "isExisted": this.isExisted,
      "time": this.time,
      "typeId": this.typeId,
    };
  }
}
