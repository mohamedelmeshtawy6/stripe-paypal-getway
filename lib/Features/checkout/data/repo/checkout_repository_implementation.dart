import 'package:checkout_payment_ui/Features/checkout/data/model/paymentInputModel/payment_input_model.dart';
import 'package:checkout_payment_ui/Features/checkout/data/model/transactionModel/transaction_model.dart';
import 'package:checkout_payment_ui/Features/checkout/data/repo/checkout_repository.dart';
import 'package:checkout_payment_ui/core/Services/paypal_services.dart';
import 'package:checkout_payment_ui/core/Services/stripe_service.dart';
import 'package:checkout_payment_ui/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class CheckoutRepoImplementation implements CheckoutRepo {
  final StripeServices? stripe;
  final PaypalServices ?paypalServices;

  CheckoutRepoImplementation({this.paypalServices,  this.stripe});


  @override
  paypalmakepayment({required BuildContext context, required TransactionModel transactionModel}) {
   
   paypalServices!.makePaymentWithPayPal(context: context, transactionModel: transactionModel);
  }

  @override
  Future<Either<Failure, void>> stripeMakePayment({required PaymentInputModel paymentInputModel})async {
     try {
      await stripe!.makePayment(paymentInput: paymentInputModel);

      return right(null);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else if (e is StripeException) {
        return left(ServerFailure(e.error.message!));
      }
      return left(ServerFailure(e.toString()));
    }

  }

 
}
