part of 'product_bloc.dart';

sealed class ProductState {
  const ProductState();
}

final class ProductLoadInProgress extends ProductState {
  const ProductLoadInProgress();
}

final class ProductLoadSuccess extends ProductState {
  final List<ProductResult> products;
  const ProductLoadSuccess({required this.products});
}

final class ProductFailure extends ProductState {
  final String message;
  const ProductFailure({required this.message});
}
