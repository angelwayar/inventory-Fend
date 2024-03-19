part of 'delete_bloc.dart';

sealed class DeleteState {
  const DeleteState();
}

final class DeleteInitial extends DeleteState {
  const DeleteInitial();
}

final class DeleteInProgress extends DeleteState {
  const DeleteInProgress();
}

final class DeleteSuccess extends DeleteState {
  const DeleteSuccess();
}

final class DeleteFailure extends DeleteState {
  final String message;
  const DeleteFailure({required this.message});
}
