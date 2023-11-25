import 'package:betta_store/core/dependencies.dart';
import 'package:betta_store/core/utils/widgets/custom.dart';
import 'package:betta_store/features/store/domain/data/repository/order_repo.dart';
import 'package:betta_store/features/store/domain/models/order_model.dart';
import 'package:betta_store/features/store/domain/models/place_order_model.dart';
import 'package:get/get.dart';

class OrderController extends GetxController implements GetxService {
  final OrderRepo orderRepo;

  OrderController({required this.orderRepo});
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  late List<OrderModel> _currentOrderList;
  List<OrderModel> get currentOrderList => _currentOrderList;
  late List<OrderModel> _sellerOrderList;
  List<OrderModel> get sellerOrderList => _sellerOrderList;
  Future<void> placeOrder(
      Function callback, PlaceOrderBody placeOrderBody) async {
    Response response = await orderRepo.placeOrder(placeOrderBody);
    if (response.statusCode == 200) {
      _isLoading = false;
      String string = response.body['message'];
      String orderId = response.body['order_id'].toString();
      callback(true, string, orderId);
    } else {
      callback(
          false, response.statusCode.toString() + response.statusText!, "-1");
    }
  }

  Future<void> getOrderList() async {
    _isLoading = true;
    Response response = await orderRepo.getOrderList();
    if (response.statusCode == 200) {
      _currentOrderList = [];
      response.body.forEach((order) {
        OrderModel orderModel = OrderModel.fromJson(order);

        _currentOrderList.add(orderModel);
        print("__________________________ success" + orderModel.toString());
      });
    } else {
      print("__________________________ failed......");

      _currentOrderList = [];
    }
    _isLoading = false;
    update();
  }

  Future<void> getOrderListForSeller() async {
    _isLoading = true;
    Response response = await orderRepo.getOrderListForSeller();
    if (response.statusCode == 200) {
      _sellerOrderList = [];
      response.body.forEach((order) {
        OrderModel orderModel = OrderModel.fromJson(order);

        _sellerOrderList.add(orderModel);
        print("__________________________ success" + orderModel.toString());
      });
    } else {
      print("__________________________ failed......");

      _sellerOrderList = [];
    }
    _isLoading = false;
    update();
  }

  Future<void> acceptOrder(int orderId, String deliveryCharge) async {
    _isLoading = true;
    Map<String, dynamic> data = {
      'order_id': orderId,
      'delivery_charge': deliveryCharge,
    };
    Response response = await orderRepo.acceptOrder(data);

    if (response.statusCode == 200) {
      Get.snackbar('Accepted SuccessFully',
          "Order Accepted successfully wait for payment and contineu");
      loadResources();
      print("__________________________ Accepted Successfully......");
    } else {
      print("__________________________ failed......" + response.statusText!);
    }
    _isLoading = false;
    update();
  }

  Future<void> processOrder(int orderId, String expectedDate) async {
    _isLoading = true;
    Map<String, dynamic> data = {
      'order_id': orderId,
      'expected_date': expectedDate,
    };
    Response response = await orderRepo.processOrder(data);
    if (response.statusCode == 200) {
      Get.snackbar('Start Processing SuccessFully',
          "Order Start Processing successfully Congradulation");
      loadResources();
      print("__________________________ proccess Successfully......");
    } else {
      print("__________________________ failed......" +
          response.statusText!.toString());
    }

    _isLoading = false;
    update();
  }

  Future<void> sendCoriour(
      int orderId, String trackingId, String deliveryPartner) async {
    _isLoading = true;
    Map<String, dynamic> data = {
      'order_id': orderId,
      'tracking_id': trackingId,
      'delivery_partner': deliveryPartner,
    };
    Response response = await orderRepo.sendOrder(data);
    if (response.statusCode == 200) {
      Get.snackbar(
          'Send SuccessFully', "Order Send successfully Congradulations");
      loadResources();
      print("__________________________ send Successfully......");
    } else {
      print("__________________________ failed......" + response.statusText!);
    }

    _isLoading = false;
    update();
  }

  Future<void> deliveredCoriour(
    int orderId,
    String instruction,
  ) async {
    _isLoading = true;
    Map<String, dynamic> data = {
      'order_id': orderId,
      'instruction': instruction,
    };
    Response response = await orderRepo.deliveredOrder(data);
    if (response.statusCode == 200) {
      loadResources();
      print("__________________________ send Successfully......");
    } else {
      print("__________________________ failed......" + response.statusText!);
    }
    Get.snackbar('Delivered SuccessFully',
        "Order Delivered successfully Congradulations");

    _isLoading = false;
    update();
  }

  Future<void> calncellCoriour(
    int orderId,
    String orderNote,
  ) async {
    _isLoading = true;
    Map<String, dynamic> data = {
      'order_id': orderId,
      'order_note': orderNote,
    };
    Response response = await orderRepo.cancellOrder(data);
    if (response.statusCode == 200) {
      Get.snackbar('Cancelled SuccessFully', "Order Cancelled successfully ");
      loadResources();
      print("__________________________ send Successfully......");
    } else {
      print("__________________________ failed......" + response.statusText!);
    }

    _isLoading = false;
    update();
  }
}
