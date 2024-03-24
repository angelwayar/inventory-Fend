import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_fend/widgets/widgets.dart';

import '../blocs/blocs.dart';
import '../utils/enum/criteria.enum.dart';
import '../utils/uppercase_text_input.util.dart';
import 'filter/filter_cubit.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    super.key,
    required this.onPressed,
  });
  final void Function({
    required CriteriaType criteria,
    required String value,
  })? onPressed;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final controller = TextEditingController();

    return Container(
      height: 80.0,
      margin: const EdgeInsets.only(bottom: 24.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24.0),
          bottomRight: Radius.circular(24.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 1,
            spreadRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 24.0),
          ClipRRect(
            borderRadius: BorderRadius.circular(24.0),
            child: Image.asset(
              'assets/logo.png',
              width: 120,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 24.0),
          Text(
            'Inventario',
            style: TextStyle(
              fontSize: 32.0,
              color: Colors.deepPurple[500],
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFFC2261B),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(24.0),
            ),
            child: TextButton(
              child: Text(
                'Filtros',
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.deepPurple[500],
                  fontWeight: FontWeight.w400,
                ),
              ),
              onPressed: () {
                filterShowDialog<String>(
                  context: context,
                  filterCubit: context.read<FilterCubit>(),
                );
              },
            ),
          ),
          const SizedBox(width: 8.0),
          BlocBuilder<FilterCubit, FilterState>(
            builder: (context, state) {
              return Text(
                state.criteria.text(),
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.deepPurple[500],
                  fontWeight: FontWeight.w400,
                ),
              );
            },
          ),
          const SizedBox(width: 8.0),
          BlocBuilder<FilterCubit, FilterState>(
            bloc: context.read<FilterCubit>(),
            builder: (context, state) {
              return state.nothing
                  ? const SizedBox()
                  : Row(
                      children: [
                        InkWell(
                          onTap: () {
                            controller.text = '';
                            context.read<FilterCubit>().onChangeFilter();
                            context
                                .read<ProductBloc>()
                                .add(const ProductRefresh());
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFC2261B),
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                            child: const Icon(Icons.clear, color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 32.0),
                        SizedBox(
                          width: 100.0,
                          child: Form(
                            key: formKey,
                            child: TextFormField(
                              controller: controller,
                              decoration: InputDecoration(
                                labelText: state.criteria.text(),
                              ),
                              inputFormatters: const [UpperCaseTextFormatter()],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Ingresar valor.';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 12.0),
                        ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              onPressed!(
                                criteria: state.criteria,
                                value: controller.text,
                              );
                            }
                          },
                          child: const Text(
                            'Buscar',
                            style: TextStyle(fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    );
            },
          ),
          const SizedBox(width: 24.0),
        ],
      ),
    );
  }
}
