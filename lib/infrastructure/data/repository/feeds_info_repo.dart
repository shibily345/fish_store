import 'package:betta_store/core/constents.dart';
import 'package:betta_store/infrastructure/data/api/api_clint.dart';
import 'package:get/get.dart';

class FeedsInfoRepo extends GetxService {
  final ApiClint apiClint;

  FeedsInfoRepo({required this.apiClint});
  Future<Response> getFeedsList() async {
    return await apiClint.getData(AppConstents.Feeds_URI);
  }
}
