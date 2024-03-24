part of 'product_bloc.dart';

enum Status { inital, inProgress, success, failure }

class ProductState {
  const ProductState({
    this.value,
    this.result,
    this.message,
    this.page = 1,
    this.perPage = 10,
    this.criteria = CriteriaType.nothing,
    this.hasReachedMax = false,
    this.status = Status.inital,
  });

  final int page;
  final int perPage;
  final String? value;
  final Status status;
  final String? message;
  final bool hasReachedMax;
  final CriteriaType? criteria;
  final ProductResultBase? result;

  ProductState copyWith({
    int? page,
    int? perPage,
    String? value,
    Status? status,
    String? message,
    bool? hasReachedMax,
    CriteriaType? criteria,
    ProductResultBase? result,
  }) {
    return ProductState(
      page: page ?? this.page,
      value: value ?? this.value,
      status: status ?? this.status,
      result: result ?? this.result,
      message: message ?? this.message,
      perPage: perPage ?? this.perPage,
      criteria: criteria ?? this.criteria,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}
