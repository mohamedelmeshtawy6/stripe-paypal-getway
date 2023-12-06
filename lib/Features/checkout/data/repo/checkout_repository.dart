import 'package:checkout_payment_ui/Features/checkout/data/model/paymentInputModel/payment_input_model.dart';
import 'package:checkout_payment_ui/Features/checkout/data/model/transactionModel/transaction_model.dart';
import 'package:checkout_payment_ui/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

abstract class CheckoutRepo {
  Future<Either<Failure, void>> stripeMakePayment(
    {required PaymentInputModel paymentInputModel});
   paypalmakepayment({required BuildContext context,required TransactionModel transactionModel});
}
