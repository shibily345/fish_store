import 'package:betta_store/core/constents.dart';
import 'package:betta_store/features/store/domain/data/api/api_clint.dart';
import 'package:get/get.dart';

class OtherFishInfoRepo extends GetxService {
  final ApiClint apiClint;

  OtherFishInfoRepo({required this.apiClint});
  Future<Response> getOtherFishList() async {
    return await apiClint.getData(AppConstents.OtherFishes_URI);
  }
}
