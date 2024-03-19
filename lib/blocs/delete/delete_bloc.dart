import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../service/http_client.service.dart';

part 'delete_event.dart';
part 'delete_state.dart';

class DeleteBloc extends Bloc<DeleteEvent, DeleteState> {
  DeleteBloc(this._dioClient) : super(const DeleteInitial()) {
    on<ProductRemoved>(_onProductRemoved);
  }

  final DioClient _dioClient;

  _onProductRemoved(ProductRemoved event, Emitter emit) async {
    try {
      emit(const DeleteInProgress());

      await _dioClient.delete(path: '/products/${event.id}/');

      emit(const DeleteSuccess());
    } catch (e) {
      emit(DeleteFailure(message: 'Error: $e'));
    }
  }
}
