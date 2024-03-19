part of 'register_product_bloc.dart';

sealed class RegisterProductEvent {
  const RegisterProductEvent();
}

final class RegisterProductSaved extends RegisterProductEvent {
  final ProductCommand productCommand;
  const RegisterProductSaved({required this.productCommand});
}
