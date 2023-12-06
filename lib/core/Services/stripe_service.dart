import 'package:checkout_payment_ui/Features/checkout/data/model/ephemeralKeyOutput/ephemeral_key_output.dart';
import 'package:checkout_payment_ui/Features/checkout/data/model/paymentInputModel/payment_input_model.dart';
import 'package:checkout_payment_ui/Features/checkout/data/model/payment_sheet_intent_backed_model/payment_sheet_intent_model.dart';
import 'package:checkout_payment_ui/core/Services/dio_api.dart';
import 'package:checkout_payment_ui/core/utils/api_keys.dart';
import 'package:checkout_payment_ui/core/utils/constant.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeServices {
  final DioApi dioApi;

  StripeServices({required this.dioApi});

  Future<PaymentSheetIntentBackedModel> createIntent(
      {required PaymentInputModel paymentInputModel}) async {
    var res = await dioApi.post(
        url: '$kBaseUrlStripe/v1/payment_intents',
        body: paymentInputModel.toJson(),
        token: ApiKeys.secreteKey);

    return PaymentSheetIntentBackedModel.fromJson(res.data);
  }

  Future<EphemeralKeyOutput> createEphemeralKeyUser(
      {required String id, required Map<String, dynamic> header}) async {
    var res = await dioApi.post(
        url: '$kBaseUrlStripe/v1/ephemeral_keys',
        body: {'customer': id},
        token: ApiKeys.secreteKey,
        headers: header);

    return EphemeralKeyOutput.fromJson(res.data);
  }

  Future initialPayment(
      {required PaymentSheetIntentBackedModel paymentSheetIntentBackedModel,
      EphemeralKeyOutput? ephemeralKeyOutput}) async {
    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
            customerId: paymentSheetIntentBackedModel.id,
            paymentIntentClientSecret:
                paymentSheetIntentBackedModel.clientSecret,
            customerEphemeralKeySecret: ephemeralKeyOutput!.secret!,
            merchantDisplayName: 'mohamed'));
  }

  Future presentPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }

  Future makePayment({required PaymentInputModel paymentInput}) async {
    PaymentSheetIntentBackedModel paymentSheetIntentBackedModel =
        await createIntent(paymentInputModel: paymentInput);
    EphemeralKeyOutput ephemeralKeyOutput = await createEphemeralKeyUser(
        id: paymentInput.id!,
        header: {
          'Authorization': "Bearer ${ApiKeys.secreteKey}",
          'Stripe-Version': "2022-11-15"
        });

    await initialPayment(
        paymentSheetIntentBackedModel: paymentSheetIntentBackedModel,
        ephemeralKeyOutput: ephemeralKeyOutput);

    await presentPaymentSheet();
  }
}
