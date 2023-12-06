import 'package:checkout_payment_ui/Features/checkout/data/repo/checkout_repository_implementation.dart';
import 'package:checkout_payment_ui/core/Services/dio_api.dart';
import 'package:checkout_payment_ui/core/Services/paypal_services.dart';
import 'package:checkout_payment_ui/core/Services/stripe_service.dart';
import 'package:get_it/get_it.dart';

var getIt = GetIt.instance;

start() {
  getIt.registerLazySingleton(() => CheckoutRepoImplementation(
      stripe: StripeServices(dioApi: DioApiImplementation()),paypalServices: PaypalServices()));
}
