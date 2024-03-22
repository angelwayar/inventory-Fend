import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_fend/blocs/blocs.dart';
import 'package:inventory_fend/models/models.dart';
import 'package:inventory_fend/pages/update_register/update_product.page.dart';
import 'package:inventory_fend/widgets/cubit/menu_cubit.dart';

import '../widgets/widgets.dart';

class ListProductContent extends StatefulWidget {
  const ListProductContent({
    super.key,
    required this.products,
    required this.hasReachedMax,
    required this.isDeleteEnable,
    required this.isUpdateEnable,
  });
  final bool hasReachedMax;
  final bool isDeleteEnable;
  final bool isUpdateEnable;
  final List<ProductResult> products;

  @override
  State<ListProductContent> createState() => _ListProductContentState();
}

class _ListProductContentState extends State<ListProductContent> {
  late Function submit;
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    submit = popup;
    scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<ProductBloc>().add(const ProductFetched());
  }

  bool get _isBottom {
    if (!scrollController.hasClients) return false;
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  void popup(ProductResult value) {
    customShowDialog(context: context, images: value.images);
  }

  delete(ProductResult value) {
    context.read<DeleteBloc>().add(ProductRemoved(id: value.id));
  }

  update(ProductResult value) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateProductPage(productResult: value),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MenuCubit, MenuState>(
      listener: (context, state) {
        if (state.enableDelete) {
          submit = delete;
        } else if (state.enableUpdate) {
          submit = update;
        } else {
          submit = popup;
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 24.0),
        child: ListView.builder(
          controller: scrollController,
          itemCount: widget.hasReachedMax
              ? widget.products.length
              : widget.products.length + 1,
          itemBuilder: (context, index) {
            if (index >= widget.products.length) {
              return const LinearProgressIndicator();
            }
            final productResult = widget.products[index];
            return Padding(
              padding: const EdgeInsets.only(right: 24.0),
              child: CardWidget(
                productResult: productResult,
                valueChanged: (value) {
                  submit(value);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
