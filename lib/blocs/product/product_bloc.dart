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
    on<ProductRefresh>(_onProductRefresh);
  }

  final DioClient _dioClient;

  Future<ProductResultBase> _fetch({int? page}) async {
    int page_ = 0;
    if (page != null && page <= state.result!.totalPages) {
      page_ = page;
    } else if (page == null) {
      page_ = state.page;
    }

    final queryParameters = {'page': page_, 'per_page': state.perPage};
    final response = await _dioClient.get(
      path: '/products/',
      queryParameters: queryParameters,
    );

    return ProductResultBase.fromJson(response);
  }

  _onProductFetched(ProductFetched event, Emitter emit) async {
    if ((state.hasReachedMax) && (event.page == null)) return;
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
      int? page = event.page;
      if (page != null) {
        emit(state.copyWith(status: Status.inProgress));
      }
      final result = await _fetch(page: page);
      final products = <ProductResult>[];
      if (page != null) {
        page = page + 1;
        products.addAll(result.products);
      } else {
        page = state.page + 1;
        products.addAll(
          List.of(state.result!.products)..addAll(result.products),
        );
      }
      emit(
        result.products.isEmpty
            ? state.copyWith(hasReachedMax: true)
            : state.copyWith(
                hasReachedMax: false,
                status: Status.success,
                page: page,
                result: state.result!.copyWith(
                  products: products,
                ),
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

  _onProductRefresh(ProductRefresh event, Emitter emit) async {
    try {
      emit(state.copyWith(status: Status.inProgress));
      final result = await _fetch(page: 1);
      emit(
        state.copyWith(
          result: result,
          hasReachedMax: false,
          page: 2,
          status: Status.success,
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
