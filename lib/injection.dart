import 'package:get_it/get_it.dart';

import 'blocs/blocs.dart';
import 'service/http_client.service.dart';

class Injector {
  static GetIt? _instance;
  static GetIt get getIt => _instance ??= GetIt.I;

  initInjector() {
    Injector.getIt;

    // Dio client
    getIt.registerLazySingleton<DioClient>(
      () => DioClient(baseUrl: 'http://127.0.0.1:8000'),
    );

    getIt.registerFactory(
      () => ProductBloc(getIt.get<DioClient>()),
    );
    getIt.registerFactory(
      () => RegisterProductBloc(getIt.get<DioClient>()),
    );
    getIt.registerFactory(
      () => DeleteBloc(getIt.get<DioClient>()),
    );
    getIt.registerFactory(
      () => UpdateProductBloc(getIt.get<DioClient>()),
    );
  }
}
