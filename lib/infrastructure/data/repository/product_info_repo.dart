import 'package:betta_store/core/constents.dart';
import 'package:betta_store/infrastructure/data/api/api_clint.dart';
import 'package:get/get.dart';

class ProductInfoRepo extends GetxService {
  final ApiClint apiClint;

  ProductInfoRepo({required this.apiClint});
  Future<Response> getProductList() async {
    return await apiClint.getData(AppConstents.PRODUCT_URI);
  }
}
