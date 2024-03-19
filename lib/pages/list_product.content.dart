import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:inventory_fend/models/models.dart';

import '../widgets/widgets.dart';

class ListProductContent extends StatelessWidget {
  const ListProductContent({
    super.key,
    required this.products,
    required this.isDeleteEnable,
    required this.isUpdateEnable,
  });
  final List<ProductResult> products;
  final bool isDeleteEnable;
  final bool isUpdateEnable;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0),
      child: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final productResult = products[index];
          return Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: CardWidget(
              productResult: productResult,
              valueChanged: (value) {
                if (isDeleteEnable) {
                  log('Se debe de eliminar');
                } else if (isUpdateEnable) {
                  log('Se debe de update');
                } else {
                  log('Se debe de Mostrar popup');
                }
              },
            ),
          );
        },
      ),
    );
  }
}
