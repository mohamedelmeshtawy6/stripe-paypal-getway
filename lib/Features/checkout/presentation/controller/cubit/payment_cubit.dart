import 'package:checkout_payment_ui/Features/checkout/data/model/paymentInputModel/payment_input_model.dart';
import 'package:checkout_payment_ui/Features/checkout/data/model/transactionModel/transaction_model.dart';
import 'package:checkout_payment_ui/Features/checkout/data/repo/checkout_repository.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit({required this.checkoutRepo}) : super(PaymentInitial());

  final CheckoutRepo checkoutRepo;

  Future<void> paymentwithStripe({required PaymentInputModel paymentInputModel}) async {
    emit(Paymentloading());

    var getback =
        await checkoutRepo.stripeMakePayment(paymentInputModel: paymentInputModel);

    getback.fold((l) {
      emit(PaymentFail(error: l.errMessage));
    }, (r) {
      emit(PaymentSuccess());
    });
  }
   paymentwithpaypal({required BuildContext context,required TransactionModel transactionModel}) async {
    

   
    await checkoutRepo.paypalmakepayment(context: context,transactionModel: transactionModel );


  }
}
