part of 'product_bloc.dart';

sealed class ProductEvent {
  const ProductEvent();
}

final class ProductFetched extends ProductEvent {
  final int? page;
  const ProductFetched({this.page});
}
