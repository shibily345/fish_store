import 'package:betta_store/core/constents.dart';
import 'package:betta_store/features/Pages/domain/data/repository/user_repo.dart';
import 'package:betta_store/features/Pages/domain/models/respones_model.dart';
import 'package:betta_store/features/Pages/domain/models/user_model.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

class UserInfoController extends GetxController implements GetxService {
  final UserRepo userRepo;

  UserInfoController({required this.userRepo});
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  UserModel? _userModel;
  UserModel get userModel => _userModel!;
  bool _isLoded = false;
  bool get isLoaded => _isLoded;
  List<dynamic> _breedersList = [];
  List<dynamic> get breedersList => _breedersList;
  Future<ResponesModel> getUserInfo() async {
    Response response = await userRepo.getUserInfo();

    late ResponesModel responesModel;
    if (response.statusCode == 200) {
      _userModel = UserModel.fromJson(response.body);
      _isLoading = true;

      responesModel = ResponesModel(true, "SuccessFull");
    } else {
      print("Getting ----${response.statusCode}--token");
      responesModel = ResponesModel(false, response.statusText!);
    }

    update();
    return responesModel;
  }

  Future<void> getBreedersList() async {
    Response response = await userRepo.getUserList();
    if (response.statusCode == 200) {
      _breedersList = [];
      _breedersList.addAll(UserList.fromJson(response.body).users!);

      print(_breedersList);
      _isLoded = true;
      update();
    } else {
      print("Fail..........${response.statusText}......................");
    }
  }

  Future<void> updateUserProfile(int userId, Map<String, dynamic> data) async {
    try {
      final response = await http.put(
        Uri.parse('${AppConstents.BASE_URL}/api/v1/auth/user/$userId/update'),
        body: data,
      );
      print(
          '||||||||||||||||||||||||||||||||||||||||||||||||||||Request Success');

      if (response.statusCode == 200) {
        print('User data updated successfully');
      } else {
        print(
            'Failed to update user data: ${response.statusCode}\n${response.body}');
        throw Exception('Failed to update user data');
      }
    } catch (error) {
      print('Error: $error');
      throw Exception('Failed to update user data');
    }
  }
}
