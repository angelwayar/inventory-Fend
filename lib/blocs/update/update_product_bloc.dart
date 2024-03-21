import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:inventory_fend/models/models.dart';

import '../../service/http_client.service.dart';

part 'update_product_event.dart';
part 'update_product_state.dart';

class UpdateProductBloc extends Bloc<UpdateProductEvent, UpdateProductState> {
  UpdateProductBloc(this._dioClient) : super(const UpdateProductInitial()) {
    on<UpdateProductSaved>(_onUpdateProductSaved);
  }

  final DioClient _dioClient;

  _onUpdateProductSaved(UpdateProductSaved event, Emitter emit) async {
    try {
      emit(const UpdateProductInProgress());
      final jsonProduct = await event.productCommand.toJson();
      final jsonImages = jsonProduct['images'];
      final targetMap = {};

      for (var key in jsonProduct.keys) {
        if (key != "images") {
          targetMap[key] = jsonProduct[key];
        }
      }

      final jsonProductEncode = json.encode(targetMap);

      final formData = FormData.fromMap({
        'product': jsonProductEncode,
        'files': jsonImages,
      });
      if (jsonImages == null) {
        formData.fields.removeAt(1);
      }

      await _dioClient.put(path: '/products/${event.id}/', data: formData);
      emit(const UpdateProductLoadSuccess());
    } catch (e) {
      emit(UpdateProductFailure(message: 'Error: $e'));
    }
  }
}
