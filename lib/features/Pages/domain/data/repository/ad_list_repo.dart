import 'package:betta_store/core/constents.dart';
import 'package:betta_store/features/Pages/domain/data/api/api_clint.dart';
import 'package:get/get.dart';

class AdListRepo {
  final ApiClint apiClint;
  AdListRepo({
    required this.apiClint,
  });
  Future<Response> getAds() async {
    return await apiClint.getData(AppConstents.ads);
  }
}
