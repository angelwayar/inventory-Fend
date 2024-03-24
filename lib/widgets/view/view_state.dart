part of 'view_cubit.dart';

class ViewState {
  const ViewState({this.isList = true});

  final bool isList;

  ViewState copyWith({bool? isList}) {
    return ViewState(isList: isList ?? this.isList);
  }
}
