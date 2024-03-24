import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_fend/pages/list_product.content.dart';
import 'package:inventory_fend/widgets/menu/menu_cubit.dart';
import 'package:inventory_fend/widgets/widgets.dart';

import '../blocs/blocs.dart';
import '../injection.dart';
import '../widgets/filter/filter_cubit.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isDeleteEnable = false;
  bool isUpdateEnable = false;
  late final ProductBloc productBloc;

  @override
  void initState() {
    productBloc = Injector.getIt<ProductBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => productBloc..add(const ProductFetched()),
        ),
        BlocProvider(create: (context) => Injector.getIt<DeleteBloc>()),
        BlocProvider(create: (context) => MenuCubit()),
        BlocProvider(create: (context) => FilterCubit()),
      ],
      child: BlocListener<DeleteBloc, DeleteState>(
        listener: (context, state) {
          if (state is DeleteSuccess) {
            context.read<ProductBloc>().add(const ProductRefresh());
            context.read<MenuCubit>().enableDelete(value: false);
          }
        },
        child: Scaffold(
          body: Column(
            children: [
              HeaderWidget(
                onPressed: ({required criteria, required value}) {
                  productBloc.add(
                    ProductFetched(page: 1, criteria: criteria, value: value),
                  );
                },
              ),
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 350.0,
                      child: MenuWidget(
                        deleteProduct: (value) => isDeleteEnable = value,
                        updateProduct: (value) => isUpdateEnable = value,
                      ),
                    ),
                    const VerticalDivider(),
                    Flexible(
                      flex: 3,
                      child: BlocBuilder<ProductBloc, ProductState>(
                        builder: (context, state) {
                          if (state.status == Status.success) {
                            final products = state.result?.products;

                            return ListProductContent(
                              products: products ?? [],
                              isDeleteEnable: isDeleteEnable,
                              isUpdateEnable: isUpdateEnable,
                              hasReachedMax: state.hasReachedMax,
                            );
                          } else if (state.status == Status.failure) {
                            return Center(
                              child: Text(
                                '${state.message}',
                                style: TextStyle(
                                  fontSize: 24.0,
                                  color: Colors.red[900],
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            );
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
