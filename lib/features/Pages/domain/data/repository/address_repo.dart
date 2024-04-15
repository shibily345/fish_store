import 'package:betta_store/core/constents.dart';
import 'package:betta_store/features/Pages/domain/data/api/api_clint.dart';
import 'package:betta_store/features/Pages/domain/models/address_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressRepo {
  final ApiClint apiClint;
  final SharedPreferences sharedPreferences;
  AddressRepo({
    required this.sharedPreferences,
    required this.apiClint,
  });
  String getUserAddress() {
    return sharedPreferences.getString(AppConstents.userAddress) ?? "";
  }

  Future<Response> addAddress(AddressModel addressModel) async {
    return await apiClint.postData(
        AppConstents.addressUri, addressModel.toJson());
  }

  Future<Response> getAllAddress() async {
    return await apiClint.getData(AppConstents.addressListUri);
  }

  Future<void> clearShareddata() async {
    await sharedPreferences.remove(AppConstents.userAddress);
  }

  Future<bool> saveUserAddress(String address) async {
    apiClint
        .updateHeader(sharedPreferences.getString(AppConstents.TOKEN) ?? "");
    return await sharedPreferences.setString(AppConstents.userAddress, address);
  }
}
