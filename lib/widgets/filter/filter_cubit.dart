import 'package:bloc/bloc.dart';

import '../../utils/enum/criteria.enum.dart';

part 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit() : super(const FilterState());

  onChangeFilter({
    bool isCode = false,
    bool isSupplier = false,
    bool isBrand = false,
    bool isYear = false,
    bool isDescription = false,
    bool nothing = true,
    CriteriaType criteria = CriteriaType.nothing,
  }) {
    emit(
      state.copyWith(
        isCode: isCode,
        isSupplier: isSupplier,
        isBrand: isBrand,
        isYear: isYear,
        isDescription: isDescription,
        nothing: nothing,
        criteria: criteria,
      ),
    );
  }
}
