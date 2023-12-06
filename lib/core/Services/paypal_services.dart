

import 'dart:developer';

import 'package:checkout_payment_ui/Features/checkout/data/model/transactionModel/transaction_model.dart';
import 'package:checkout_payment_ui/Features/checkout/presentation/views/thank_you_view.dart';
import 'package:checkout_payment_ui/core/utils/api_Keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';

class PaypalServices {
  makePaymentWithPayPal(
      {required BuildContext context,
      required TransactionModel transactionModel}) {
   

    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => UsePaypal(
        sandboxMode: true,
        returnURL: "https://samplesite.com/return",
        cancelURL: "https://samplesite.com/cancel",
        clientId: ApiKeys.paypalClientId,
        secretKey: ApiKeys.paypalSecreteKey,
        transactions: [transactionModel.toJson()],
        note: "Contact us for any questions on your order.",
        onSuccess: (Map params) async {
         log("onSuccess: $params");
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) {
            return const ThankYouView();
          }));
        },
        onError: (error) {
          log("onError: $error");
          Navigator.pop(context);
          SnackBar snackBar = SnackBar(content: Text(error));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        onCancel: () {
          print('cancelled:');
          Navigator.pop(context);
          SnackBar snackBar = const SnackBar(content:  Text('process was cancelled '));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
      ),
    ));
  }
}
