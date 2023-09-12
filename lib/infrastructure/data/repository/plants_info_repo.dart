import 'package:betta_store/core/constents.dart';
import 'package:betta_store/infrastructure/data/api/api_clint.dart';
import 'package:get/get.dart';

class PlantsInfoRepo extends GetxService {
  final ApiClint apiClint;

  PlantsInfoRepo({required this.apiClint});
  Future<Response> getPlantsList() async {
    return await apiClint.getData(AppConstents.Plants_URI);
  }
}
