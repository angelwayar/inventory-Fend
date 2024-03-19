import 'package:get_it/get_it.dart';

import 'blocs/blocs.dart';
import 'service/http_client.service.dart';

class Injector {
  static GetIt? _instance;
  static GetIt get getIt => _instance ??= GetIt.I;

  initInjector() {
    Injector.getIt;

    // Dio client
    // TODO: IP para el emulador y desde el celular fisico
    // () => DioClient(baseUrl: 'http://10.0.2.2:8080'), -> IP para el emulador
    // () => DioClient(baseUrl: 'http://192.168.0.14:8080'), -> IP para el celular con wifi
    getIt.registerLazySingleton<DioClient>(
      () => DioClient(baseUrl: 'http://127.0.0.1:8000'),
    );

    getIt.registerFactory(
      () => ProductBloc(getIt.get<DioClient>()),
    );
    getIt.registerFactory(
      () => RegisterProductBloc(getIt.get<DioClient>()),
    );
  }
}
