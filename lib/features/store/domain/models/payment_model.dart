class EasyUpiPaymentModel {
  final String payeeVpa;
  final String payeeName;
  final String? payeeMerchantCode;
  final String? transactionId;
  final String? transactionRefId;
  final String? description;
  final double amount;

  const EasyUpiPaymentModel({
    required this.payeeVpa,
    required this.payeeName,
    required this.amount,
    required this.description,
    this.payeeMerchantCode,
    this.transactionId,
    this.transactionRefId,
  });
}

class TransactionDetailModel {
  final String? transactionId;
  final String? responseCode;
  final String? approvalRefNo;
  final String? transactionRefId;
  final String? amount;

  const TransactionDetailModel({
    required this.transactionId,
    required this.responseCode,
    required this.approvalRefNo,
    required this.transactionRefId,
    required this.amount,
  });
}
