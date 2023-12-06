part of 'payment_cubit.dart';

sealed class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

class PaymentInitial extends PaymentState {}

class Paymentloading extends PaymentState {}

class PaymentSuccess extends PaymentState {}

class PaymentFail extends PaymentState {
  final String error;

  const PaymentFail({required this.error});
}
