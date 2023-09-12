// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  int id;
  String name;
  String phone;
  String email;

  int orderCount;
  UserModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.orderCount,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        name: json['f_name'],
        phone: json['phone'],
        email: json['email'],
        orderCount: json['order_count']);
  }
}
