part of 'product_bloc.dart';

sealed class ProductEvent {
  const ProductEvent();
}

// Se lanzan a traves de la pantalla, ya sea por un boton o entrando a una pagina
final class ProductFetched extends ProductEvent {
  const ProductFetched();
}
