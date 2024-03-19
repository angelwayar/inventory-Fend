import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../models/models.dart';
import 'text_information.widget.dart';

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
  Uint8List imageFile({required String base64Image}) {
    Uint8List bytes = base64Decode(base64Image);
    return bytes;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12.0),
        decoration: BoxDecoration(
          color: Colors.black38,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 1,
              spreadRadius: 2,
              offset: Offset(0, 1), // Shadow position
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if ((widget.productResult.images != null) ||
                (widget.productResult.images![0].isNotEmpty))
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  bottomLeft: Radius.circular(15.0),
                ),
                child: Image.memory(
                  imageFile(
                    base64Image: widget.productResult.images![0],
                  ),
                  width: 400.0,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 280.0,
                      width: 400.0,
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.0),
                          bottomLeft: Radius.circular(15.0),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'No tiene Imagen',
                          style: TextStyle(
                            fontSize: 24.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            const SizedBox(width: 36.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextInformationWidget(
                  label: 'Altura:',
                  text:
                      '${widget.productResult.height == null || widget.productResult.height == 'None' ? '' : widget.productResult.height}',
                ),
                TextInformationWidget(
                  label: 'Ancho:',
                  text:
                      '${widget.productResult.width == null || widget.productResult.width == 'None' ? '' : widget.productResult.width}',
                ),
                TextInformationWidget(
                  label: 'Grosor:',
                  text:
                      '${widget.productResult.depth == null || widget.productResult.depth == 'None' ? '' : widget.productResult.depth}',
                ),
                TextInformationWidget(
                  label: 'Description:',
                  text:
                      '${widget.productResult.description == null || widget.productResult.description == 'None' ? '' : widget.productResult.description}',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
