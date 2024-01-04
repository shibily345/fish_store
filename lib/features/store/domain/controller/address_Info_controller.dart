import 'dart:convert';

import 'package:betta_store/features/store/domain/data/repository/address_repo.dart';
import 'package:betta_store/features/store/domain/models/address_model.dart';
import 'package:betta_store/features/store/domain/models/respones_model.dart';
import 'package:betta_store/features/store/domain/models/user_model.dart';
import 'package:get/get.dart';

class AddressInfoController extends GetxController implements GetxService {
  final AddressRepo addressRepo;

  AddressInfoController({required this.addressRepo});
  bool _isLoading = false;
  late UserModel _userModel;
  bool get isLoading => _isLoading;
  UserModel get userModel => _userModel;
  // late Map<String, dynamic> _getAddress;
  // Map<String, dynamic> get getAddress => _getAddress;

  List<AddressModel> _addressList = [];
  List<AddressModel> get addressList => _addressList;
  late List<AddressModel> _allAddressList = [];
  List<AddressModel> get allAddressList => _allAddressList;
  // AddressModel getUserAddress() {
  //   late AddressModel _addressModel;
  //   _getAddress = jsonDecode(addressRepo.getUserAddress());
  //   try {
  //     _addressModel =
  //         AddressModel.fromJson(jsonDecode(addressRepo.getUserAddress()));
  //   } catch (e) {
  //     print(e);
  //   }
  //   return _addressModel;
  // }

  AddressModel getUserAddress() {
    final String userAddressJson = addressRepo.getUserAddress();
    if (userAddressJson.isEmpty) {
      // Handle empty or null response
      return AddressModel(
        name: "",
        addressType: "",
        address: "",
        phone: "",
        pincode: "",
        secondoryPhone: "",
      );
    }

    AddressModel addressModel;
    try {
      // Validate JSON data
      json.decode(userAddressJson);
      addressModel = AddressModel.fromJson(jsonDecode(userAddressJson));
    } catch (e) {
      print("Error parsing or validating user address JSON: $e");
      // Handle parsing error, e.g., return a default AddressModel or throw an exception
      return AddressModel(
        name: "",
        addressType: "",
        address: "",
        phone: "",
        pincode: "",
        secondoryPhone: "",
      ); // Default AddressModel object
    }
    return addressModel;
  }

  Future<ResponesModel> addAddress(AddressModel addressModel) async {
    _isLoading = true;
    update();
    Response response = await addressRepo.addAddress(addressModel);
    ResponesModel responseModel;
    if (response.statusCode == 200) {
      await getAddressList();
      String message = response.body["message"];
      responseModel = ResponesModel(true, message);
      await saveUserAddress(addressModel);
    } else {
      print("Nadakkola bosse...............");
      responseModel = ResponesModel(false, response.statusText!);
    }
    update();
    return responseModel;
  }

  Future<void> getAddressList() async {
    Response response = await addressRepo.getAllAddress();
    if (response.status == 200) {
      // _getAddress = AddressModel.fromJson(response.body);
      _isLoading = true;
      _addressList = [];
      _allAddressList = [];
      response.body.forEach((address) {
        _addressList.add(AddressModel.fromJson(address));
        _allAddressList.add(AddressModel.fromJson(address));
      });
    } else {
      _addressList = [];
      _allAddressList = [];
    }
    update();
  }

  // AddressModel getaddresslist() {
  //   _getAddress = getUserAddress();
  //   return _getAddress;
  // }

  Future<bool> saveUserAddress(AddressModel addressModel) async {
    String userAddress = jsonEncode(addressModel.toJson());
    return await addressRepo.saveUserAddress(userAddress);
  }

  void clearAddressList() {
    _addressList = [];
    _allAddressList = [];
    addressRepo.clearShareddata();
    update();
  }

  String getUserAddressFromLocalStorage() {
    return addressRepo.getUserAddress();
  }
}
