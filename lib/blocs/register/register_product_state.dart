part of 'register_product_bloc.dart';

@immutable
sealed class RegisterProductState {
  const RegisterProductState();
}

final class RegisterProductInitial extends RegisterProductState {
  const RegisterProductInitial();
}

final class RegisterProductInProgress extends RegisterProductState {
  const RegisterProductInProgress();
}

final class RegisterProductLoadSuccess extends RegisterProductState {
  const RegisterProductLoadSuccess();
}

final class RegisterProductFailure extends RegisterProductState {
  final String message;
  const RegisterProductFailure({required this.message});
}
