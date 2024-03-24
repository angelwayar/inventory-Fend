import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../utils/enum/criteria.enum.dart';
import 'filter/filter_cubit.dart';

Future<T?> filterShowDialog<T extends Object>({
  required BuildContext context,
  required FilterCubit filterCubit,
  String? title,
  String? description,
  List<String>? images,
  double height = 120.0,
  double width = 120.0,
}) async {
  return showDialog<T>(
    useSafeArea: true,
    context: context,
    builder: (context) {
      return Material(
        type: MaterialType.transparency,
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.4,
            vertical: 160.0,
          ),
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24.0),
          ),
          child: BlocBuilder<FilterCubit, FilterState>(
            bloc: filterCubit,
            builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'Código: ',
                        style: TextStyle(fontSize: 24.0),
                      ),
                      const Spacer(),
                      Checkbox(
                          value: state.isCode,
                          onChanged: (bool? value) {
                            filterCubit.onChangeFilter(
                              isCode: !state.isCode,
                              nothing: false,
                              criteria: CriteriaType.code,
                            );
                          }),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'Proveedor: ',
                        style: TextStyle(fontSize: 24.0),
                      ),
                      const Spacer(),
                      Checkbox(
                        value: state.isSupplier,
                        onChanged: (bool? value) {
                          filterCubit.onChangeFilter(
                            isSupplier: !state.isSupplier,
                            nothing: false,
                            criteria: CriteriaType.supplier,
                          );
                        },
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'Marca: ',
                        style: TextStyle(fontSize: 24.0),
                      ),
                      const Spacer(),
                      Checkbox(
                          value: state.isBrand,
                          onChanged: (bool? value) {
                            filterCubit.onChangeFilter(
                              isBrand: !state.isBrand,
                              nothing: false,
                              criteria: CriteriaType.brand,
                            );
                          }),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'Año: ',
                        style: TextStyle(fontSize: 24.0),
                      ),
                      const Spacer(),
                      Checkbox(
                          value: state.isYear,
                          onChanged: (bool? value) {
                            filterCubit.onChangeFilter(
                              isYear: !state.isYear,
                              nothing: false,
                              criteria: CriteriaType.year,
                            );
                          }),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'Descripción: ',
                        style: TextStyle(fontSize: 24.0),
                      ),
                      const Spacer(),
                      Checkbox(
                          value: state.isDescription,
                          onChanged: (bool? value) {
                            filterCubit.onChangeFilter(
                              isDescription: !state.isDescription,
                              nothing: false,
                              criteria: CriteriaType.description,
                            );
                          }),
                    ],
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Cerrar',
                      style: TextStyle(fontSize: 24.0),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      );
    },
  );
}
