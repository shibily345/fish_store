import 'package:betta_store/features/store/domain/models/address_model.dart';

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
        ? new AddressModel.fromJson(json['delivery_address'])
        : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['seller_id'] = this.sellerId;
    data['order_amount'] = this.orderAmount;
    data['payment_status'] = this.paymentStatus;
    data['total_tax_amount'] = this.totalTaxAmount;
    data['order_note'] = this.orderNote;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['delivery_charge'] = this.deliveryCharge;
    data['schedule_at'] = this.scheduleAt;
    data['otp'] = this.otp;
    data['pending'] = this.pending;
    data['accepted'] = this.accepted;
    data['confirmed'] = this.confirmed;
    data['processing'] = this.processing;
    data['handover'] = this.handover;
    data['picked_up'] = this.pickedUp;
    data['delivered'] = this.delivered;
    data['canceled'] = this.canceled;
    data['refund_requested'] = this.refundRequested;
    data['refunded'] = this.refunded;
    data['scheduled'] = this.scheduled;
    data['failed'] = this.failed;
    data['details_count'] = this.detailsCount;
    if (this.deliveryAddress != null) {
      data['delivery_address'] = this.deliveryAddress?.toJson();
    }
    return data;
  }
}
