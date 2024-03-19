import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_fend/pages/list_product.content.dart';
import 'package:inventory_fend/widgets/widgets.dart';

import '../blocs/blocs.dart';
import '../injection.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isDeleteEnable = false;
  bool isUpdateEnable = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          Injector.getIt<ProductBloc>()..add(const ProductFetched()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Row(
          children: [
            MenuWidget(
              deleteProduct: (value) => isDeleteEnable = value,
              updateProduct: (value) => isUpdateEnable = value,
            ),
            BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoadSuccess) {
                  return Expanded(
                    child: ListProductContent(
                      products: state.products,
                      isDeleteEnable: isDeleteEnable,
                      isUpdateEnable: isUpdateEnable,
                    ),
                  );
                } else if (state is ProductFailure) {
                  return Center(
                    child: Text(
                      state.message,
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.red[900],
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
    );
  }
}
