import 'package:checkout_payment_ui/Features/checkout/data/model/paymentInputModel/payment_input_model.dart';
import 'package:checkout_payment_ui/Features/checkout/data/model/transactionModel/amount.dart';
import 'package:checkout_payment_ui/Features/checkout/data/model/transactionModel/details.dart';
import 'package:checkout_payment_ui/Features/checkout/data/model/transactionModel/item.dart';
import 'package:checkout_payment_ui/Features/checkout/data/model/transactionModel/item_list.dart';
import 'package:checkout_payment_ui/Features/checkout/data/model/transactionModel/transaction_model.dart';
import 'package:checkout_payment_ui/Features/checkout/presentation/controller/cubit/payment_cubit.dart';
import 'package:checkout_payment_ui/Features/checkout/presentation/views/thank_you_view.dart';
import 'package:checkout_payment_ui/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomButtonBlocConsumer extends StatelessWidget {
  const CustomButtonBlocConsumer({
    super.key,
    required this.isPaypal,
  });

  final bool isPaypal;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentCubit, PaymentState>(
      listener: (context, state) {
        if (state is PaymentSuccess) {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) {
            return const ThankYouView();
          }));
        }

        if (state is PaymentFail) {
          Navigator.of(context).pop();
          SnackBar snackBar = SnackBar(content: Text(state.error));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        return CustomButton(
            onTap: () {
              if (isPaypal) {
                excutepaypalPayment(context);
              } else if (!isPaypal) {
                excuteStripePayment(context);
              }
            },
            isLoading: state is Paymentloading ? true : false,
            text: 'Continue');
      },
    );
  }

  void excuteStripePayment(BuildContext context) {
    PaymentInputModel paymentIntentInputModel = PaymentInputModel(
      totalPrice: '100',
      currency: 'USD',
      id: 'cus_P6MAkDDvifsrK2',
    );
    BlocProvider.of<PaymentCubit>(context)
        .paymentwithStripe(paymentInputModel: paymentIntentInputModel);
  }

  void excutepaypalPayment(BuildContext context) {
    BlocProvider.of<PaymentCubit>(context).paymentwithpaypal(
        context: context,
        transactionModel: TransactionModel(
            amount: Amount(
                total: '100',
                currency: 'USD',
                details: Details(
                    subtotal: '100', shipping: '0', shippingDiscount: 0)),
            description: 'The payment transaction description',
            itemList: ItemList(items: [
              Item(name: 'apple', price: '10', currency: 'USD', quantity: 4),
              Item(name: 'Pineapple', price: '12', currency: 'USD', quantity: 5)
            ])));
  }
}
