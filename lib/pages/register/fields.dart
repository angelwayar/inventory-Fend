import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../widgets/widgets.dart';

class FieldWidget extends StatelessWidget {
  const FieldWidget({
    super.key,
    required this.codeController,
    required this.supplierController,
    required this.yearController,
    required this.brandController,
    required this.heightController,
    required this.widthController,
    required this.depthController,
    required this.descriptionController,
    required this.images,
    this.arrayImages,
  });

  final TextEditingController codeController;
  final TextEditingController supplierController;
  final TextEditingController yearController;
  final TextEditingController brandController;
  final TextEditingController heightController;
  final TextEditingController widthController;
  final TextEditingController depthController;
  final TextEditingController descriptionController;
  final List<String>? arrayImages;
  final ValueChanged<List<XFile>> images;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              TextField(
                controller: codeController,
                decoration: const InputDecoration(
                  labelText: 'Código',
                ),
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
              const SizedBox(height: 32.0),
              Container(
                height: 320.0,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red),
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
        const SizedBox(width: 24.0),
        Expanded(
          child: Column(
            children: [
              TextField(
                controller: heightController,
                decoration: const InputDecoration(
                  labelText: 'Altura',
                ),
              ),
              TextField(
                controller: widthController,
                decoration: const InputDecoration(
                  labelText: 'Ancho',
                ),
              ),
              TextField(
                controller: depthController,
                decoration: const InputDecoration(
                  labelText: 'Grosor',
                ),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Descripción',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
