class UserList {
  List<UserModel>? users;

  UserList({this.users});

  UserList.fromJson(Map<String, dynamic> json) {
    if (json['users'] != null) {
      users = <UserModel>[];
      json['users'].forEach((v) {
        users!.add(UserModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (users != null) {
      data['users'] = users!.map((v) => v.toJson()).toList();
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
  String? upiId;
  int? status;
  int? sellproduct;
  String? balance;
  String? totelb;
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
      this.upiId,
      this.sellproduct,
      this.balance,
      this.totelb,
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
    upiId = json['payment_id'];
    sellproduct = json['sellproduct'];
    balance = json['balance'];
    totelb = json['totel_balance'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    productCount = json['product_count'];
    orderCount = json['order_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['phone'] = phone;
    data['logo'] = logo;
    data['email'] = email;
    data['location'] = location;
    data['status'] = status;
    data['payment_id'] = upiId;
    data['sellproduct'] = sellproduct;
    data['balance'] = balance;
    data['totel_balance'] = totelb;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['product_count'] = productCount;
    data['order_count'] = orderCount;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    if (location!.isNotEmpty) data['location'] = location;
    if (productCount != 0) data['product_count'] = productCount;
    if (logo!.isNotEmpty) data['logo'] = logo;
    if (sellProduct != 0) data['sellproduct'] = sellProduct;
    return data;
  }
}
