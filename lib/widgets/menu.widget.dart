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
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width * 0.3,
      decoration: const BoxDecoration(
        color: Colors.grey,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 4,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: Column(
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
                child: const Text(
                  'Editar item',
                  style: TextStyle(
                    fontSize: 24.0,
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
                child: const Text(
                  'Eliminar item',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 24.0),
          ElevatedButton(
            onPressed: () {},
            style: const ButtonStyle(
              minimumSize: MaterialStatePropertyAll<Size>(
                Size(350.0, 80.0),
              ),
            ),
            child: const Text(
              'Listar items',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: 24.0),
          Container(
            height: 150.0,
            width: 200.0,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red),
              borderRadius: BorderRadius.circular(24.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Total de páginas: ${widget.totalPages}',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  width: 120.0,
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      labelText: 'Ingresar pagina',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<ProductBloc>().add(
                          ProductFetched(page: int.parse(controller.text)),
                        );
                  },
                  child: const Text('Buscar pagina'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
