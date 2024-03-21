part of 'update_product_bloc.dart';

sealed class UpdateProductEvent {
  const UpdateProductEvent();
}

class UpdateProductSaved extends UpdateProductEvent {
  final String id;
  final ProductCommand productCommand;
  const UpdateProductSaved({required this.id, required this.productCommand});
}
