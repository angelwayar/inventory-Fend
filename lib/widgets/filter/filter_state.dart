part of 'filter_cubit.dart';

final class FilterState {
  const FilterState({
    this.isCode = false,
    this.isSupplier = false,
    this.isBrand = false,
    this.isYear = false,
    this.isDescription = false,
    this.nothing = true,
    this.criteria = CriteriaType.nothing,
  });

  final bool isCode;
  final bool isSupplier;
  final bool isBrand;
  final bool isYear;
  final bool isDescription;
  final bool nothing;
  final CriteriaType criteria;

  FilterState copyWith({
    bool? isCode,
    bool? isSupplier,
    bool? isBrand,
    bool? isYear,
    bool? isDescription,
    bool? nothing,
    CriteriaType? criteria,
  }) {
    return FilterState(
      isCode: isCode ?? this.isCode,
      isSupplier: isSupplier ?? this.isSupplier,
      isBrand: isBrand ?? this.isBrand,
      isYear: isYear ?? this.isYear,
      isDescription: isDescription ?? this.isDescription,
      nothing: nothing ?? this.nothing,
      criteria: criteria ?? this.criteria,
    );
  }
}
