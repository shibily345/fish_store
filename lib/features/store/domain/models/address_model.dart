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
    addressType,
    address,
    phone,
    pincode,
    secondoryPhone,
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
    _name = json['contact_person_name'];
    _address = json['address'];
    _phone = json['contact_person_number'];
    _pincode = json['longitude'];
    _secondoryPhone = json['latitude'];
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
