import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/models.dart';
import '../../service/http_client.service.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc(this._dioClient) : super(const ProductLoadInProgress()) {
    on<ProductFetched>(_onProductFetched);
  }

  final DioClient _dioClient;

  _onProductFetched(ProductFetched event, Emitter emit) async {
    try {
      final response = await _dioClient.get(path: '/products/');
      final products = response
          .map<ProductResult>(
            (json) => ProductResult.fromJson(json),
          )
          .toList();

      emit(ProductLoadSuccess(products: products));
    } catch (e) {
      emit(ProductFailure(message: 'Error: $e'));
    }
  }
}
