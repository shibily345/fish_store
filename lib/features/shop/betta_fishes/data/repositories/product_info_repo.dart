import 'package:betta_store/core/constents.dart';
import 'package:betta_store/features/store/domain/data/api/api_clint.dart';
import 'package:betta_store/features/store/domain/models/products_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProductInfoRepo extends GetxService {
  final ApiClint apiClint;

  ProductInfoRepo({required this.apiClint});
  Future<Response> getProductList() async {
    return await apiClint.getData(AppConstents.Betta_Fish_URI);
  }

  Future<Response> addProduct(ProductModel productModel) async {
    return await apiClint.postData(
        AppConstents.addProductUri, productModel.toJson());
  }
}
