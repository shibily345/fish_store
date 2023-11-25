import 'package:betta_store/core/constents.dart';
import 'package:betta_store/features/store/domain/data/api/api_clint.dart';
import 'package:betta_store/features/store/domain/models/place_order_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderRepo {
  final ApiClint apiClint;

  OrderRepo({
    required this.apiClint,
  });
  Future<Response> placeOrder(PlaceOrderBody placeOrderBody) async {
    debugPrint(placeOrderBody.toJson().toString());
    return await apiClint.postData(
        AppConstents.placeOrderUri, placeOrderBody.toJson());
  }

  Future<Response> getOrderList() async {
    return await apiClint.getData(AppConstents.getOrderListUri);
  }

  Future<Response> getOrderListForSeller() async {
    return await apiClint.getData(AppConstents.getOrderListForSellerUri);
  }

  Future<Response> acceptOrder(dynamic data) async {
    return await apiClint.putData('/api/v1/customer/order/accept', data);
  }

  Future<Response> processOrder(dynamic data) async {
    return await apiClint.putData('/api/v1/customer/order/processing', data);
  }

  Future<Response> sendOrder(dynamic data) async {
    return await apiClint.putData('/api/v1/customer/order/handover', data);
  }

  Future<Response> deliveredOrder(dynamic data) async {
    return await apiClint.putData('/api/v1/customer/order/delivered', data);
  }

  Future<Response> cancellOrder(dynamic data) async {
    return await apiClint.putData('/api/v1/customer/order/cancelled', data);
  }
}
