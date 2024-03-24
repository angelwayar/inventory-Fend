part of 'product_bloc.dart';

sealed class ProductEvent {
  const ProductEvent();
}

final class ProductFetched extends ProductEvent {
  final int? page;
  final CriteriaType? criteria;
  final String? value;

  const ProductFetched({this.page, this.criteria, this.value});
}

final class ProductRefresh extends ProductEvent {
  const ProductRefresh();
}
