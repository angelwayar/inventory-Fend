import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/decimal_text_input.util.dart';
import '../../widgets/widgets.dart';

class FieldWidget extends StatelessWidget {
  const FieldWidget({
    super.key,
    this.formKey,
    this.arrayImages,
    required this.codeController,
    required this.supplierController,
    required this.yearController,
    required this.brandController,
    required this.heightController,
    required this.widthController,
    required this.depthController,
    required this.retailController,
    required this.wholesaleRetailController,
    required this.wholesaleMajorController,
    required this.descriptionController,
    required this.images,
  });

  final TextEditingController codeController;
  final TextEditingController supplierController;
  final TextEditingController yearController;
  final TextEditingController brandController;
  final TextEditingController heightController;
  final TextEditingController widthController;
  final TextEditingController depthController;
  final TextEditingController descriptionController;
  final TextEditingController retailController;
  final TextEditingController wholesaleRetailController;
  final TextEditingController wholesaleMajorController;
  final List<String>? arrayImages;
  final ValueChanged<List<XFile>> images;
  final GlobalKey<FormState>? formKey;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, bottom: 4.0),
                  child: Text(
                    'DETALLES',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple[900],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFFC2261B),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: codeController,
                        decoration: const InputDecoration(
                          labelText: 'Código',
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Se debe de agregar el Código.';
                          }
                          return null;
                        },
                      ),
                      TextField(
                        controller: supplierController,
                        decoration: const InputDecoration(
                          labelText: 'Proveedor',
                        ),
                      ),
                      TextField(
                        controller: yearController,
                        decoration: const InputDecoration(
                          labelText: 'Año',
                        ),
                      ),
                      TextField(
                        controller: brandController,
                        decoration: const InputDecoration(
                          labelText: 'Marca',
                        ),
                      ),
                      TextField(
                        controller: descriptionController,
                        decoration: const InputDecoration(
                          labelText: 'Descripción',
                        ),
                      ),
                      const SizedBox(height: 24.0),
                    ],
                  ),
                ),
                const SizedBox(height: 24.0),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, bottom: 4.0),
                  child: Text(
                    'IMAGENES',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple[900],
                    ),
                  ),
                ),
                Container(
                  height: 320.0,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFFC2261B),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  child: UploadImagesWidget(
                    initialImages: arrayImages,
                    imagesSeleted: (value) {
                      images(value);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 24.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12.0, bottom: 4.0),
                child: Text(
                  'DIMENSIONES',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple[900],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFFC2261B),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(24.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: heightController,
                      decoration: const InputDecoration(
                        labelText: 'Altura',
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+[\,.]?\d{0,2}'),
                        ),
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d*'),
                        ),
                        const DecimalTextInputFormatter(),
                      ],
                    ),
                    TextField(
                      controller: widthController,
                      decoration: const InputDecoration(
                        labelText: 'Ancho',
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+[\,.]?\d{0,2}'),
                        ),
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d*'),
                        ),
                        const DecimalTextInputFormatter(),
                      ],
                    ),
                    TextField(
                      controller: depthController,
                      decoration: const InputDecoration(
                        labelText: 'Grosor',
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+[\,.]?\d{0,2}'),
                        ),
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d*'),
                        ),
                        const DecimalTextInputFormatter(),
                      ],
                    ),
                    const SizedBox(height: 24.0),
                  ],
                ),
              ),
              const SizedBox(height: 24.0),
              Padding(
                padding: const EdgeInsets.only(left: 12.0, bottom: 4.0),
                child: Text(
                  'PRECIOS',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple[900],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFFC2261B),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(24.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: retailController,
                      decoration: const InputDecoration(
                        labelText: 'Precio',
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+[\,.]?\d{0,2}'),
                        ),
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d*'),
                        ),
                        const DecimalTextInputFormatter(),
                      ],
                    ),
                    TextField(
                      controller: wholesaleRetailController,
                      decoration: const InputDecoration(
                        labelText: 'Por mayor - mínimo',
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+[\,.]?\d{0,2}'),
                        ),
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d*'),
                        ),
                        const DecimalTextInputFormatter(),
                      ],
                    ),
                    TextField(
                      controller: wholesaleMajorController,
                      decoration: const InputDecoration(
                        labelText: 'Por mayor - máximo',
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+[\,.]?\d{0,2}'),
                        ),
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d*'),
                        ),
                        const DecimalTextInputFormatter(),
                      ],
                    ),
                    const SizedBox(height: 24.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
