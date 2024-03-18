import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_fend/widgets/widgets.dart';

import '../blocs/blocs.dart';
import '../injection.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductBloc>(
      create: (context) =>
          Injector.getIt<ProductBloc>()..add(const ProductFetched()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Row(
          children: [
            const MenuWidget(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    if (state is ProductLoadSuccess) {
                      return ListView.builder(
                        itemCount: 20,
                        itemBuilder: (context, index) {
                          return const CardWidget();
                        },
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
                    return const SizedBox(
                      height: 40.0,
                      width: 10.0,
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
