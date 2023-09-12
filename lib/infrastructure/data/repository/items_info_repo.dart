import 'package:betta_store/core/constents.dart';
import 'package:betta_store/infrastructure/data/api/api_clint.dart';
import 'package:get/get.dart';

class ItemsInfoRepo extends GetxService {
  final ApiClint apiClint;

  ItemsInfoRepo({required this.apiClint});
  Future<Response> getItemsList() async {
    return await apiClint.getData(AppConstents.Items_URI);
  }
}
