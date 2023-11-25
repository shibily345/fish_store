import 'package:betta_store/core/constents.dart';
import 'package:betta_store/features/store/domain/data/api/api_clint.dart';
import 'package:betta_store/features/store/domain/models/signup_body_model.dart';
import 'package:betta_store/features/store/domain/models/user_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepo {
  final ApiClint apiClint;

  UserRepo({
    required this.apiClint,
  });
  Future<Response> getUserInfo() async {
    return await apiClint.getData(
      AppConstents.userUri,
    );
  }

  Future<Response> getUserList() async {
    return await apiClint.getData(AppConstents.userList);
  }

  Future<Response> updateUserProfile(UserModel userData) async {
    return await apiClint.postData(AppConstents.updateUser, userData);
  }
}
