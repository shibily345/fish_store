import 'package:betta_store/features/Pages/domain/data/repository/ad_list_repo.dart';
import 'package:betta_store/features/Pages/domain/models/ad_list.dart';
import 'package:betta_store/features/Pages/domain/models/respones_model.dart';
import 'package:get/get.dart';

class AdlistController extends GetxController implements GetxService {
  final AdListRepo adListRepo;

  AdlistController({required this.adListRepo});
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<AdListModel> _ads = [];
  List<AdListModel> get ads => _ads;

  Future<ResponesModel> getAllads() async {
    Response response = await adListRepo.getAds();

    late ResponesModel responesModel;
    _ads = [];
    if (response.statusCode == 200) {
      response.body.forEach((ads) {
        AdListModel adslist = AdListModel.fromJson(ads);
        _ads.add(adslist);
      });
      _isLoading = true;

      print("$_ads>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
      responesModel = ResponesModel(true, "SuccessFull");
    } else {
      _ads = [];
      print("failed.....ad  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
      responesModel = ResponesModel(false, response.statusText!);
    }

    update();
    return responesModel;
  }

  // Future<void> getProductInfoList() async {
  //   Response response = await adListRepo.getAds();
  //   if (response.statusCode == 200) {
  //     print(
  //         "Got It ........................................................................................................");
  //     _ads = [];
  //     _ads.addAll(AdListModel.fromJson(response.body).ads);
  //     _isLoded = true;
  //     print(_ads);
  //     update();
  //   } else {
  //     print("Fail..........${response.statusText}......................");
  //   }
  // }
}
