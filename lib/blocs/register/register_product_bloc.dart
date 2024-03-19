import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../models/models.dart';
import '../../service/http_client.service.dart';

part 'register_product_event.dart';
part 'register_product_state.dart';

class RegisterProductBloc
    extends Bloc<RegisterProductEvent, RegisterProductState> {
  RegisterProductBloc(this._dioClient) : super(const RegisterProductInitial()) {
    on<RegisterProductSaved>(_onRegisterProductSaved);
  }

  final DioClient _dioClient;

  _onRegisterProductSaved(RegisterProductSaved event, Emitter emit) async {
    try {
      emit(const RegisterProductInProgress());
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

      await _dioClient.post(
        path: '/products/save',
        data: formData,
      );

      emit(const RegisterProductLoadSuccess());
    } catch (e) {
      emit(RegisterProductFailure(message: 'Eerro: $e'));
    }
  }
}
