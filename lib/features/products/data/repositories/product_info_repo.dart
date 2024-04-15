import 'package:betta_store/core/constents.dart';
import 'package:betta_store/features/Pages/domain/data/api/api_clint.dart';
import 'package:betta_store/features/Pages/domain/models/products_model.dart';
import 'package:get/get.dart';

class ProductInfoRepo extends GetxService {
  final ApiClint apiClint;

  ProductInfoRepo({required this.apiClint});
  Future<Response> getProductList() async {
    return await apiClint.getData(AppConstents.allProductUri);
  }

  Future<Response> addProduct(ProductModel productModel) async {
    return await apiClint.postData(
        AppConstents.addProductUri, productModel.toJson());
  }
}
