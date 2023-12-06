class PaymentInputModel {
  final String totalPrice;
  final String currency;
  final String? id;

  PaymentInputModel(
      {this.id, required this.totalPrice, required this.currency});

  toJson() {
    return {'amount': '${totalPrice}00', 'currency': currency, 'customer': id};
  }
}
