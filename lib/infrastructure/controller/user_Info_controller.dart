import 'package:betta_store/infrastructure/data/repository/user_repo.dart';
import 'package:betta_store/infrastructure/models/respones_model.dart';
import 'package:betta_store/infrastructure/models/user_model.dart';
import 'package:get/get.dart';

class UserInfoController extends GetxController implements GetxService {
  final UserRepo userRepo;

  UserInfoController({required this.userRepo});
  bool _isLoading = false;
  late UserModel _userModel;
  bool get isLoading => _isLoading;
  UserModel get userModel => _userModel;
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
}
