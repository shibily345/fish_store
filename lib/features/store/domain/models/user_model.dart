class UserList {
  List<UserModel>? users;

  UserList({this.users});

  UserList.fromJson(Map<String, dynamic> json) {
    if (json['users'] != null) {
      users = <UserModel>[];
      json['users'].forEach((v) {
        users!.add(new UserModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserModel {
  int? id;
  String? name;
  String? phone;
  String? logo;
  String? email;
  String? location;
  String? fcmToken;
  int? status;
  int? sellproduct;
  String? createdAt;
  String? updatedAt;
  int? productCount;
  int? orderCount;

  UserModel(
      {this.id,
      required this.name,
      required this.phone,
      required this.logo,
      required this.email,
      required this.location,
      this.status,
      this.fcmToken,
      this.sellproduct,
      this.createdAt,
      this.updatedAt,
      this.productCount,
      this.orderCount});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['f_name'];
    phone = json['phone'];
    logo = json['logo'];
    email = json['email'];
    location = json['location'];
    status = json['status'];
    fcmToken = json['cm_firebase_token'];
    sellproduct = json['sellproduct'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    productCount = json['product_count'];
    orderCount = json['order_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['phone'] = this.phone;
    data['logo'] = this.logo;
    data['email'] = this.email;
    data['location'] = this.location;
    data['status'] = this.status;
    data['sellproduct'] = this.sellproduct;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['product_count'] = this.productCount;
    data['order_count'] = this.orderCount;
    return data;
  }
}

class SellerModel {
  String? location;
  int? productCount;
  String? logo;
  int? sellProduct;

  SellerModel({this.location, this.productCount, this.logo, this.sellProduct});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (location!.isNotEmpty) data['location'] = location;
    if (productCount != 0) data['product_count'] = productCount;
    if (logo!.isNotEmpty) data['logo'] = logo;
    if (sellProduct != 0) data['sellproduct'] = sellProduct;
    return data;
  }
}
