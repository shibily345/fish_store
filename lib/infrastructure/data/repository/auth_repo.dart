import 'package:betta_store/core/constents.dart';
import 'package:betta_store/infrastructure/data/api/api_clint.dart';
import 'package:betta_store/infrastructure/models/signup_body_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final ApiClint apiClint;
  final SharedPreferences sharedPreferences;

  AuthRepo({required this.apiClint, required this.sharedPreferences});
  Future<Response> registration(SignUpBody signUpBody) async {
    return await apiClint.postData(
        AppConstents.registrationUri, signUpBody.toJson());
  }

  Future<String> getUserToken() async {
    return await sharedPreferences.getString(AppConstents.TOKEN) ?? "none";
  }

  bool userLogedIn() {
    return sharedPreferences.containsKey(AppConstents.TOKEN);
  }

  Future<Response> login(String phone, String password) async {
    print(phone + "________" + password);
    return await apiClint.postData(
        AppConstents.loginUri, {"phone": phone, "password": password});
  }

  Future<bool> savedUserToken(String token) async {
    apiClint.token = token;
    apiClint.updateHeader(token);
    return await sharedPreferences.setString(AppConstents.TOKEN, token);
  }

  Future<void> saveUserNumberAndPassword(String number, String password) async {
    try {
      await sharedPreferences.setString("", number);
      await sharedPreferences.setString("", password);
    } catch (e) {
      throw e;
    }
  }

  bool clearAllSharedData() {
    sharedPreferences.remove(
      AppConstents.TOKEN,
    );
    sharedPreferences.remove(
      "",
    );
    sharedPreferences.remove(
      '',
    );
    apiClint.token = '';
    apiClint.updateHeader('');
    return true;
  }
}
