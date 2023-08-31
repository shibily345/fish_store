// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:betta_store/infrastructure/models/fish_detile_model.dart';

class CartModel {
  int? id;
  String? name;
  double? price;
  String? img;
  int? totquantity;
  int? pquantity;
  int? mquantity;
  int? fquantity;
  bool? isExisted;
  String? time;
  ProductModel? product;

  CartModel(
      {this.id,
      this.name,
      this.price,
      this.img,
      this.totquantity,
      this.pquantity,
      this.mquantity,
      this.fquantity,
      this.isExisted,
      this.time,
      this.product});

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    img = json['img'];
    totquantity = json['quantity'];
    pquantity = json['quantity'];
    mquantity = json['quantity'];
    fquantity = json['quantity'];
    isExisted = json['isExisted'];
    time = json['time'];
    product = ProductModel.fromJson(json['product']);
  }
  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "name": this.name,
      "price": this.price,
      "img": this.img,
      "totquantity": this.totquantity,
      "pquantity": this.pquantity,
      "mquantity": this.mquantity,
      "fquantity": this.fquantity,
      "isExisted": this.isExisted,
      "time": this.time,
    };
  }
}
