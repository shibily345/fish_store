import 'package:betta_store/core/constents.dart';
import 'package:betta_store/features/store/domain/data/api/api_clint.dart';
import 'package:betta_store/features/store/domain/models/address_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdListRepo {
  final ApiClint apiClint;
  AdListRepo({
    required this.apiClint,
  });
  Future<Response> getAds() async {
    return await apiClint.getData(AppConstents.ads);
  }
}
