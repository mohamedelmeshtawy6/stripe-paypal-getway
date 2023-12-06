import 'package:checkout_payment_ui/Features/checkout/presentation/views/my_cart_view.dart';
import 'package:checkout_payment_ui/Features/checkout/presentation/views/widgets/thank_you_view_body.dart';
import 'package:checkout_payment_ui/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class ThankYouView extends StatelessWidget {
  const ThankYouView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (con) => const MyCartView()));
      }),
      body: Transform.translate(
          offset: const Offset(0, -16), child: const ThankYouViewBody()),
    );
  }
}
