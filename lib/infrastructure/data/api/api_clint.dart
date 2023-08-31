import 'package:betta_store/core/constents.dart';
import 'package:get/get.dart';

class ApiClint extends GetConnect implements GetxService {
  late String token;
  final String appBaseUrl;
  late Map<String, String> _mainHeders;
  ApiClint({required this.appBaseUrl}) {
    baseUrl = appBaseUrl;
    timeout = Duration(seconds: 30);
    token = AppConstents.TOKEN;
    _mainHeders = {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };
  }
  Future<Response> getData(
    String uri,
  ) async {
    try {
      Response response = await get('/api/v1/products/betta');
      return response;
    } catch (e) {
      return Response(statusCode: 0, statusText: e.toString());
    }
  }
}
