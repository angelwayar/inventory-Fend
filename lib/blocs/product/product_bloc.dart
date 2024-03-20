import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../models/models.dart';
import '../../service/http_client.service.dart';

part 'product_event.dart';
part 'product_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc(this._dioClient) : super(const ProductState()) {
    on<ProductFetched>(
      _onProductFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final DioClient _dioClient;

  Future<ProductResultBase> _fetch() async {
    final queryParameters = {'page': state.page, 'per_page': state.perPage};
    final response = await _dioClient.get(
      path: '/products/',
      queryParameters: queryParameters,
    );
    return ProductResultBase.fromJson(response);
  }

  _onProductFetched(ProductFetched event, Emitter emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == Status.inital) {
        final result = await _fetch();
        emit(
          state.copyWith(
            result: result,
            hasReachedMax: false,
            page: state.page + 1,
            status: Status.success,
          ),
        );
      }
      final result = await _fetch();
      emit(
        result.products.isEmpty
            ? state.copyWith(hasReachedMax: true)
            : state.copyWith(
                status: Status.success,
                result: state.result!.copyWith(
                  products: List.of(state.result!.products)
                    ..addAll(result.products),
                ),
                hasReachedMax: false,
              ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: Status.failure,
          message: 'Error: $e',
        ),
      );
    }
  }
}
