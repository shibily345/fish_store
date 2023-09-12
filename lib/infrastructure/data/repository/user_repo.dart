import 'package:betta_store/core/constents.dart';
import 'package:betta_store/infrastructure/data/api/api_clint.dart';
import 'package:betta_store/infrastructure/models/signup_body_model.dart';
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
}
