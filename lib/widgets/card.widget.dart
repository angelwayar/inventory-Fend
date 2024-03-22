import 'package:flutter/material.dart';

import '../models/models.dart';
import 'image_content.widget.dart';
import 'widgets.dart';

class CardWidget extends StatefulWidget {
  const CardWidget({
    super.key,
    required this.productResult,
    required this.valueChanged,
  });

  final ProductResult productResult;
  final ValueChanged<ProductResult> valueChanged;

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.valueChanged(widget.productResult),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12.0),
        decoration: BoxDecoration(
          color: Colors.deepPurple[50],
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 1,
              spreadRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ImageContentWidget(productResult: widget.productResult),
            const SizedBox(width: 36.0),
            Expanded(
              child: SizedBox(
                height: 280.0,
                width: double.infinity,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextInformationWidget(
                          label: 'Código:',
                          text:
                              '${widget.productResult.code == null || widget.productResult.code == 'None' ? '' : widget.productResult.code}',
                        ),
                        TextInformationWidget(
                          label: 'Marca:',
                          text:
                              '${widget.productResult.brand == null || widget.productResult.brand == 'None' ? '' : widget.productResult.brand}',
                        ),
                        TextInformationWidget(
                          label: 'Proveedor:',
                          text:
                              '${widget.productResult.supplier == null || widget.productResult.supplier == 'None' ? '' : widget.productResult.supplier}',
                        ),
                        TextInformationWidget(
                          label: 'Año:',
                          text:
                              '${widget.productResult.year == null || widget.productResult.year == 'None' ? '' : widget.productResult.year}',
                        ),
                      ],
                    ),
                    const SizedBox(width: 36.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextInformationWidget(
                            label: 'Altura:',
                            text: '${widget.productResult.height ?? ''}',
                          ),
                          TextInformationWidget(
                            label: 'Ancho:',
                            text: '${widget.productResult.width ?? ''}',
                          ),
                          TextInformationWidget(
                            label: 'Grosor:',
                            text: '${widget.productResult.depth ?? ''}',
                          ),
                          TextInformationWidget(
                            label: 'Description:',
                            text:
                                '${widget.productResult.description == null || widget.productResult.description == 'None' ? '' : widget.productResult.description}',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
