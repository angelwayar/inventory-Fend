part of 'update_product_bloc.dart';

sealed class UpdateProductState {
  const UpdateProductState();
}

final class UpdateProductInitial extends UpdateProductState {
  const UpdateProductInitial();
}

final class UpdateProductInProgress extends UpdateProductState {
  const UpdateProductInProgress();
}

final class UpdateProductLoadSuccess extends UpdateProductState {
  const UpdateProductLoadSuccess();
}

final class UpdateProductFailure extends UpdateProductState {
  final String message;
  const UpdateProductFailure({required this.message});
}
