import 'package:betta_store/features/store/domain/data/repository/auth_repo.dart';
import 'package:betta_store/features/store/domain/models/respones_model.dart';
import 'package:betta_store/features/store/domain/models/signup_body_model.dart';
import 'package:get/get.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;

  AuthController({required this.authRepo});
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  Future<ResponesModel> registration(SignUpBody signUpBody) async {
    _isLoading = true;
    update();
    Response response = await authRepo.registration(signUpBody);
    late ResponesModel responesModel;
    if (response.statusCode == 200) {
      authRepo.savedUserToken(response.body["token"]);
      responesModel = ResponesModel(true, response.body["token"]);
    } else {
      responesModel = ResponesModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responesModel;
  }

  Future<ResponesModel> login(String phone, String password) async {
    print("Getting -----------------------token");
    print("${authRepo.getUserToken()}=======================");
    _isLoading = true;
    update();
    Response response = await authRepo.login(phone, password);
    late ResponesModel responesModel;
    if (response.statusCode == 200) {
      authRepo.savedUserToken(response.body["token"]);
      print("my token is ---------" + response.body["token"]);
      responesModel = ResponesModel(true, response.body["token"]);
    } else {
      print(response.statusCode);
      responesModel = ResponesModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responesModel;
  }

  bool userLogedIn() {
    return authRepo.userLogedIn();
  }

  void saveUserNumberAndPassword(String number, String password) async {
    authRepo.saveUserNumberAndPassword(number, password);
  }

  bool clearSharedData() {
    update();
    return authRepo.clearAllSharedData();
  }

  Future<void> updateToken() async {
    await authRepo.updateToken();
  }

  Future<void> resetPsd(String phone, String newPsd) async {
    await authRepo.resetPsd(phone, newPsd);
  }
}
