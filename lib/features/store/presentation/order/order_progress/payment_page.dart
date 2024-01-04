
import 'package:betta_store/core/utils/widgets/buttons.dart';
import 'package:betta_store/core/utils/widgets/spaces.dart';
import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/features/store/domain/controller/order_controller.dart';
import 'package:betta_store/features/store/domain/controller/user_Info_controller.dart';
import 'package:betta_store/features/store/domain/models/user_model.dart';
import 'package:betta_store/features/store/presentation/booking/placed_page.dart';
import 'package:betta_store/features/store/presentation/my_shop/order/widgets/product_detail.dart';
import 'package:easy_upi_payment/easy_upi_payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage(
      {super.key,
      required this.order,
      required this.product,
      required this.user});

  final dynamic order;
  final UserModel user;
  final dynamic product;

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  TransactionDetailModel? res;
  @override
  void initState() {
    super.initState();
    if (res != null) {
      print(
          "---------------${res!.responseCode}-====-=-==========================------------------------==========-=-===-=-");
    }
  }

  late Razorpay _razorpay;

  Future<void> makePay() async {
    res = await EasyUpiPaymentPlatform.instance.startPayment(
      EasyUpiPaymentModel(
        payeeVpa: '8943047476@paytm',
        payeeName: 'Betta Store',
        amount: widget.order.deliveryCharge + widget.order.orderAmount,
        description: 'Testing payment',
      ),
    );
    print(
        "---------------${res!.responseCode}-====-=-==========================------------------------==========-=-===-=-");
    // TODO: add your success logic here
    print(res);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    double amount = widget.order.deliveryCharge + widget.order.orderAmount;
    double balance =
        double.parse(Get.find<UserInfoController>().userModel.balance!) +
            amount;
    double totb =
        double.parse(Get.find<UserInfoController>().userModel.totelb!) + amount;
    // Print the updated balance
    print(
        'Updated balance: ${Get.find<UserInfoController>().userModel.balance}');
    Fluttertoast.showToast(
        msg: "Payment Successful ${response.paymentId!}",
        toastLength: Toast.LENGTH_SHORT);
    Get.find<OrderController>().payOrder(
        widget.order.id, amount.toString(), widget.product.sellerId.toString());
    Map<String, dynamic> data = {
      'balance': balance.toString(),
      'totel_balance': totb.toString(),
    };
    Get.find<UserInfoController>()
        .updateUserProfile(widget.product.sellerId, data);
    Get.to(() => const OrderPlaced());
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "Payment failed ${response.message!}",
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "Wallet  ${response.walletName!} Sselected",
        toastLength: Toast.LENGTH_SHORT);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  // @override
  // void initState() {
  //   _razorpay = Razorpay();
  //   _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
  //   _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
  //   _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: textWidget(
            text: "Payment Page",
            color: Theme.of(context).indicatorColor,
            fontSize: 17),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 100,
        color: Theme.of(context).splashColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            textWidget(
                text:
                    'Total Price:   ₹  ${widget.order.deliveryCharge + widget.order.orderAmount}',
                color: Theme.of(context).indicatorColor,
                fontSize: 17),
            const SizedBox(
              height: 16.0,
            ),
            SimpleButton(
              onPress: () {
                makePay();
              },
              label: "Pay now",
            ),
          ]),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
                width: Get.width,
                // height: 200,
                decoration: BoxDecoration(
                    color: Theme.of(context).splashColor,
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                    child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
                  child: ProductDetailWidget(
                    product: widget.product,
                    order: widget.order,
                  ),
                ))),
            bigSpace,
            Container(
                width: Get.width,
                height: 80,
                decoration: BoxDecoration(
                    color: Theme.of(context).splashColor,
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textWidget(
                          text: 'Delivery Charge: ',
                          color: Theme.of(context).indicatorColor,
                          fontSize: 17),
                      textWidget(
                          text: "₹  ${widget.order.deliveryCharge}",
                          color: Theme.of(context).indicatorColor,
                          fontSize: 17),
                    ],
                  ),
                ))),
            smallSpace,
            Container(
                width: Get.width,
                height: 80,
                decoration: BoxDecoration(
                    color: Theme.of(context).splashColor,
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textWidget(
                          text: 'Product Price: ',
                          color: Theme.of(context).indicatorColor,
                          fontSize: 17),
                      textWidget(
                          text: "₹  ${widget.order.orderAmount}",
                          color: Theme.of(context).indicatorColor,
                          fontSize: 17),
                    ],
                  ),
                ))),
          ],
        ),
      ),
    );
  }
}
