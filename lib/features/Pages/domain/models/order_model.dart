import 'package:betta_store/features/Pages/domain/models/address_model.dart';

class OrderModel {
  late int id;
  late int userId;
  String? sellerId;
  double? orderAmount;
  String? orderStatus;
  String? img;
  int? productId;
  int? quantity;
  int? maleQuantity;
  int? femaleQuantity;
  String? paymentStatus;
  double? totalTaxAmount;
  String? orderNote;
  String? createdAt;
  String? updatedAt;
  int? deliveryCharge;
  String? scheduleAt;
  String? otp;
  String? pending;
  String? accepted;
  String? confirmed;
  String? processing;
  String? handover;
  String? trackId;
  String? deliveryCompany;
  String? instruction;
  String? pickedUp;
  String? delivered;
  String? canceled;
  String? refundRequested;
  String? refunded;
  String? scheduled;
  String? failed;
  int? detailsCount;

  AddressModel? deliveryAddress;

  OrderModel({
    required this.id,
    required this.userId,
    required this.sellerId,
    this.productId,
    this.quantity,
    this.maleQuantity,
    this.femaleQuantity,
    this.orderAmount,
    this.paymentStatus,
    this.orderNote,
    this.createdAt,
    this.updatedAt,
    this.deliveryCharge,
    this.scheduleAt,
    this.otp,
    this.orderStatus,
    this.pending,
    this.accepted,
    this.confirmed,
    this.processing,
    this.handover,
    this.deliveryCompany,
    this.instruction,
    this.trackId,
    this.pickedUp,
    this.delivered,
    this.canceled,
    this.scheduled,
    this.failed,
    this.detailsCount,
    this.deliveryAddress,
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    sellerId = json['seller_id'] ?? 'kk';
    img = json['product_img'] ?? '';
    productId = json['product_id'] ?? 0;
    quantity = json['quantity'] ?? 0;
    maleQuantity = json['male_quantity'] ?? 0;
    femaleQuantity = json['female_quantity'] ?? 0;
    orderAmount = json['order_amount'].toDouble();
    paymentStatus = json['payment_status'] ?? "Booked";
    totalTaxAmount = 10.0;
    orderNote = json['order_note'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    orderStatus = json['order_status'];
    deliveryCharge = json['delivery_charge'];
    scheduleAt = json['schedule_at'] ?? "";
    otp = json['otp'];
    pending = json['pending'] ?? "";
    accepted = json['accepted'];
    confirmed = json['confirmed'] ?? "";
    processing = json['processing'];
    handover = json['handover'];
    trackId = json['tracking_id'];
    deliveryCompany = json['delivery_partner'];
    instruction = json['instruction'];
    pickedUp = json['picked_up'];
    delivered = json['delivered'];
    canceled = json['canceled'];
    scheduled = json['scheduled'];
    failed = json['failed'] ?? "";
    detailsCount = json['details_count'];

    deliveryAddress = (json['delivery_address'] != null
        ? AddressModel.fromJson(json['delivery_address'])
        : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['seller_id'] = sellerId;
    data['order_amount'] = orderAmount;
    data['payment_status'] = paymentStatus;
    data['total_tax_amount'] = totalTaxAmount;
    data['order_note'] = orderNote;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['delivery_charge'] = deliveryCharge;
    data['schedule_at'] = scheduleAt;
    data['otp'] = otp;
    data['pending'] = pending;
    data['accepted'] = accepted;
    data['confirmed'] = confirmed;
    data['processing'] = processing;
    data['handover'] = handover;
    data['picked_up'] = pickedUp;
    data['delivered'] = delivered;
    data['canceled'] = canceled;
    data['refund_requested'] = refundRequested;
    data['refunded'] = refunded;
    data['scheduled'] = scheduled;
    data['failed'] = failed;
    data['details_count'] = detailsCount;
    if (deliveryAddress != null) {
      data['delivery_address'] = deliveryAddress?.toJson();
    }
    return data;
  }
}
