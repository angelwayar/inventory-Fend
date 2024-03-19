part of 'menu_cubit.dart';

class MenuState {
  const MenuState({
    this.enableDelete = false,
    this.enableUpdate = false,
  });

  final bool enableDelete;
  final bool enableUpdate;

  MenuState copyWith({
    bool? enableDelete,
    bool? enableUpdate,
  }) {
    return MenuState(
      enableDelete: enableDelete ?? this.enableDelete,
      enableUpdate: enableUpdate ?? this.enableUpdate,
    );
  }
}
