import 'dart:convert';

import 'package:betta_store/core/constents.dart';
import 'package:betta_store/core/utils/widgets/custom.dart';
import 'package:betta_store/features/store/domain/data/api/api_clint.dart';
import 'package:betta_store/features/store/domain/models/signup_body_model.dart';
import 'package:betta_store/features/store/domain/models/user_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
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

  Future<Response> updateToken() async {
    String? _deviceToken;
    _deviceToken = await _saveDeviceToken();
    print("Token is $_deviceToken");
    return await apiClint
        .putData(AppConstents.tokenUri, {"cm_firebase_token": _deviceToken});
  }

  Future<String?> _saveDeviceToken() async {
    String? _deviceToken = '@';
    if (!GetPlatform.isWeb) {
      try {
        FirebaseMessaging.instance.requestPermission();
        _deviceToken = await FirebaseMessaging.instance.getToken();
      } catch (e) {}
    }
    if (_deviceToken != null) {
      debugPrint("token--------------" + _deviceToken);
    }
    return _deviceToken;
  }

  Future<Response> resetPsd(String phone, String newPsd) async {
    print("Token is $newPsd");
    return await apiClint.putData(AppConstents.resetPsd, {
      "phone": phone,
      "new_password": newPsd,
    });
  }
}
