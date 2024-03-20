import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_fend/widgets/cubit/menu_cubit.dart';

import '../pages/register/register_product.page.dart';

class MenuWidget extends StatefulWidget {
  const MenuWidget({
    super.key,
    required this.deleteProduct,
    required this.updateProduct,
    required this.onPressedBack,
    required this.onPressedForward,
  });

  final ValueChanged<bool> deleteProduct;
  final ValueChanged<bool> updateProduct;
  final void Function()? onPressedBack;
  final void Function()? onPressedForward;

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  bool delete = false;
  bool update = false;

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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_back_ios),
              ),
              const Text('1...150'),
              IconButton(
                onPressed: widget.onPressedForward,
                icon: const Icon(Icons.arrow_forward_ios),
              ),
            ],
          )
        ],
      ),
    );
  }
}
