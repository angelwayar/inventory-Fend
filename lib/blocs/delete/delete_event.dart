part of 'delete_bloc.dart';

@immutable
sealed class DeleteEvent {
  const DeleteEvent();
}

final class ProductRemoved extends DeleteEvent {
  final String id;
  const ProductRemoved({required this.id});
}
