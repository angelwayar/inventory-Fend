import 'package:bloc/bloc.dart';

part 'view_state.dart';

class ViewCubit extends Cubit<ViewState> {
  ViewCubit() : super(const ViewState());

  onChangeView({bool value = true}) {
    emit(state.copyWith(isList: value));
  }
}
