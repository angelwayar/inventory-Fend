import 'package:bloc/bloc.dart';

part 'menu_state.dart';

class MenuCubit extends Cubit<MenuState> {
  MenuCubit() : super(const MenuState());

  enableDelete({required bool value}) {
    emit(state.copyWith(
      enableDelete: value,
      enableUpdate: false,
    ));
  }

  enableUpdate({required bool value}) {
    emit(state.copyWith(
      enableDelete: false,
      enableUpdate: value,
    ));
  }
}
