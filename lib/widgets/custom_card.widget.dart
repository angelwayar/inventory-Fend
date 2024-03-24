import 'package:flutter/material.dart';

import '../models/models.dart';
import 'image_content.widget.dart';
import 'text_information.widget.dart';

class CustomCardWidget extends StatefulWidget {
  const CustomCardWidget({
    super.key,
    required this.productResult,
    required this.valueChanged,
  });

  final ProductResult productResult;
  final ValueChanged<ProductResult> valueChanged;

  @override
  State<CustomCardWidget> createState() => _CustomCardWidgetState();
}

class _CustomCardWidgetState extends State<CustomCardWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.valueChanged(widget.productResult),
      child: Container(
        margin: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          color: Colors.deepPurple[50],
          borderRadius: BorderRadius.circular(24.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 1,
              spreadRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ImageContentWidget(
              productResult: widget.productResult,
              borderRadius: BorderRadius.circular(24.0),
              fit: BoxFit.cover,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
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
                      label: 'Año:',
                      text:
                          '${widget.productResult.year == null || widget.productResult.year == 'None' ? '' : widget.productResult.year}',
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
