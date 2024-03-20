part of 'product_bloc.dart';

enum Status { inital, inProgress, success, failure }

class ProductState {
  const ProductState({
    this.result,
    this.message,
    this.page = 1,
    this.perPage = 10,
    this.hasReachedMax = false,
    this.status = Status.inital,
  });

  final int page;
  final int perPage;
  final Status status;
  final String? message;
  final ProductResultBase? result;
  final bool hasReachedMax;

  ProductState copyWith({
    int? page,
    int? perPage,
    Status? status,
    String? message,
    bool? hasReachedMax,
    ProductResultBase? result,
  }) {
    return ProductState(
      page: page ?? this.page,
      status: status ?? this.status,
      result: result ?? this.result,
      message: message ?? this.message,
      perPage: perPage ?? this.perPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}
