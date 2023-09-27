class AddressModel {
  late int? _id;
  late String _name;

  late String _address;
  late String _phone;
  late String _pincode;
  late String _secondoryPhone;

  AddressModel({
    id,
    required name,
    required addressType,
    required address,
    required phone,
    required pincode,
    required secondoryPhone,
  }) {
    _id = id;
    _name = name;

    _address = address;
    _phone = phone;
    _pincode = pincode;
    _secondoryPhone = secondoryPhone;
  }

  String get name => _name;

  String get address => _address;
  String get phone => _phone;
  String get pincode => _pincode;
  String get secondoryPhone => _secondoryPhone;
  AddressModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];

    _address = json['address'];
    _phone = json['phone'];
    _pincode = json['pincode'];
    _secondoryPhone = json['secondoryPhone'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['contact_person_name'] = this._name;
    data['address'] = this._address;
    data['longitude'] = this._pincode;
    data['contact_person_number'] = this._phone;
    data['latitude'] = this._secondoryPhone;

    return data;
  }
}
