import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_fend/widgets/cubit/menu_cubit.dart';

import '../blocs/blocs.dart';
import '../pages/register/register_product.page.dart';

class MenuWidget extends StatefulWidget {
  const MenuWidget({
    super.key,
    required this.totalPages,
    required this.deleteProduct,
    required this.updateProduct,
  });

  final int totalPages;
  final ValueChanged<bool> deleteProduct;
  final ValueChanged<bool> updateProduct;

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  bool delete = false;
  bool update = false;
  final formKey = GlobalKey<FormState>();
  final controller = TextEditingController();

  @override
  void initState() {
    controller.addListener(() {
      if (controller.text.isNotEmpty) {
        final value = int.parse(controller.text);
        if (value < 1) {
          controller.text = '1';
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      children: [
        const SizedBox(height: 24.0),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const RegisterProductPage(),
              ),
            );
          },
          style: const ButtonStyle(
            minimumSize: MaterialStatePropertyAll<Size>(
              Size(350.0, 80.0),
            ),
          ),
          child: const Text(
            'Agregar item',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const SizedBox(height: 24.0),
        BlocBuilder<MenuCubit, MenuState>(
          builder: (context, state) {
            return ElevatedButton(
              onPressed: () {
                context
                    .read<MenuCubit>()
                    .enableUpdate(value: !state.enableUpdate);
              },
              style: ButtonStyle(
                minimumSize: const MaterialStatePropertyAll<Size>(
                  Size(350.0, 80.0),
                ),
                backgroundColor: state.enableUpdate
                    ? const MaterialStatePropertyAll<Color>(Colors.amber)
                    : null,
              ),
              child: Text(
                'Editar item',
                style: TextStyle(
                  fontSize: 24.0,
                  color: state.enableUpdate ? Colors.white : null,
                  fontWeight: FontWeight.w400,
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 24.0),
        BlocBuilder<MenuCubit, MenuState>(
          builder: (context, state) {
            return ElevatedButton(
              onPressed: () {
                context
                    .read<MenuCubit>()
                    .enableDelete(value: !state.enableDelete);
              },
              style: ButtonStyle(
                minimumSize: const MaterialStatePropertyAll<Size>(
                  Size(350.0, 80.0),
                ),
                backgroundColor: state.enableDelete
                    ? MaterialStatePropertyAll<Color>(Colors.red[600]!)
                    : null,
              ),
              child: Text(
                'Eliminar item',
                style: TextStyle(
                  fontSize: 24.0,
                  color: state.enableDelete ? Colors.white : null,
                  fontWeight: FontWeight.w400,
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 24.0),
        BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            return ElevatedButton(
              onPressed: state.status == Status.inProgress
                  ? null
                  : () =>
                      context.read<ProductBloc>().add(const ProductRefresh()),
              style: const ButtonStyle(
                minimumSize: MaterialStatePropertyAll<Size>(
                  Size(350.0, 80.0),
                ),
              ),
              child: state.status == Status.inProgress
                  ? const CircularProgressIndicator()
                  : const Text(
                      'Listar items',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
            );
          },
        ),
        const SizedBox(height: 24.0),
        Container(
          height: 180.0,
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xFFC2261B),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(24.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Total de páginas: ${widget.totalPages}',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.deepPurple[600],
                ),
              ),
              SizedBox(
                width: 120.0,
                child: Form(
                  key: formKey,
                  child: TextFormField(
                    controller: controller,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      labelText: 'Ingresar página',
                      labelStyle: TextStyle(color: Colors.deepPurple[600]),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Ingresar una valor.';
                      } else {
                        final page = int.parse(value);
                        if (page > widget.totalPages) {
                          return 'El número de página\ntiene que ser menor.';
                        }
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 6.0),
              BlocBuilder<ProductBloc, ProductState>(
                bloc: context.read<ProductBloc>(),
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: state.status == Status.inProgress
                        ? null
                        : () {
                            if (formKey.currentState!.validate()) {
                              if (controller.text.isNotEmpty) {
                                context.read<ProductBloc>().add(
                                      ProductFetched(
                                        page: int.parse(controller.text),
                                      ),
                                    );
                              }
                            }
                          },
                    child: state.status == Status.inProgress
                        ? const CircularProgressIndicator()
                        : const Text('Buscar página'),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
