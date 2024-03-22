import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_fend/models/models.dart';
import 'package:inventory_fend/pages/register/fields.dart';

import '../../blocs/blocs.dart';
import '../../injection.dart';
import '../../utils/convert_base64_to_XFile.util.dart';
import '../home.page.dart';

class UpdateProductPage extends StatefulWidget {
  const UpdateProductPage({
    super.key,
    required this.productResult,
  });

  final ProductResult productResult;

  @override
  State<UpdateProductPage> createState() => _RegisterProductPageState();
}

class _RegisterProductPageState extends State<UpdateProductPage> {
  late ProductCommand productCommand;
  late final TextEditingController codeController;
  late final TextEditingController supplierController;
  late final TextEditingController yearController;
  late final TextEditingController brandController;
  late final TextEditingController heightController;
  late final TextEditingController widthController;
  late final TextEditingController depthController;
  late final TextEditingController retailController;
  late final TextEditingController wholesaleRetailController;
  late final TextEditingController wholesaleMajorController;
  late final TextEditingController descriptionController;

  @override
  void initState() {
    productCommand = ProductCommand(
      code: widget.productResult.code,
      supplier: widget.productResult.supplier,
      description: widget.productResult.description,
      year: widget.productResult.year,
      height: widget.productResult.height,
      width: widget.productResult.width,
      depth: widget.productResult.depth,
      retail: widget.productResult.retail,
      wholesaleRetail: widget.productResult.wholesaleRetail,
      wholesaleMajor: widget.productResult.wholesaleMajor,
      brand: widget.productResult.brand,
      images: [],
    );

    codeController = TextEditingController(text: productCommand.code);
    supplierController = TextEditingController(
      text: productCommand.supplier,
    );
    yearController = TextEditingController(text: productCommand.year);
    brandController = TextEditingController(text: productCommand.brand);
    heightController = TextEditingController(
      text: productCommand.height == null
          ? '0.0'
          : productCommand.height.toString(),
    );
    widthController = TextEditingController(
      text: productCommand.width == null
          ? '0.0'
          : productCommand.width.toString(),
    );
    depthController = TextEditingController(
      text: productCommand.depth == null
          ? '0.0'
          : productCommand.depth.toString(),
    );
    retailController = TextEditingController(
      text: productCommand.retail == null
          ? '0.0'
          : productCommand.retail.toString(),
    );
    wholesaleRetailController = TextEditingController(
      text: productCommand.wholesaleRetail == null
          ? '0.0'
          : productCommand.wholesaleRetail.toString(),
    );
    wholesaleMajorController = TextEditingController(
      text: productCommand.wholesaleMajor == null
          ? '0.0'
          : productCommand.wholesaleMajor.toString(),
    );
    descriptionController = TextEditingController(
      text: productCommand.description,
    );

    codeController.addListener(() {
      productCommand = productCommand.copyWith(code: codeController.text);
    });
    supplierController.addListener(() {
      productCommand = productCommand.copyWith(
        supplier: supplierController.text,
      );
    });
    yearController.addListener(() {
      productCommand = productCommand.copyWith(year: yearController.text);
    });
    brandController.addListener(() {
      productCommand = productCommand.copyWith(brand: brandController.text);
    });
    heightController.addListener(() {
      productCommand = productCommand.copyWith(
        height: heightController.text.isEmpty
            ? 0.0
            : double.parse(heightController.text),
      );
    });
    widthController.addListener(() {
      productCommand = productCommand.copyWith(
        width: widthController.text.isEmpty
            ? 0.0
            : double.parse(widthController.text),
      );
    });
    depthController.addListener(() {
      productCommand = productCommand.copyWith(
        depth: depthController.text.isEmpty
            ? 0.0
            : double.parse(depthController.text),
      );
    });
    retailController.addListener(() {
      productCommand = productCommand.copyWith(
        retail: retailController.text.isEmpty
            ? 0.0
            : double.parse(retailController.text),
      );
    });
    wholesaleRetailController.addListener(() {
      productCommand = productCommand.copyWith(
        wholesaleRetail: wholesaleRetailController.text.isEmpty
            ? 0.0
            : double.parse(wholesaleRetailController.text),
      );
    });
    wholesaleMajorController.addListener(() {
      productCommand = productCommand.copyWith(
        wholesaleMajor: wholesaleMajorController.text.isEmpty
            ? 0.0
            : double.parse(wholesaleMajorController.text),
      );
    });
    descriptionController.addListener(() {
      productCommand = productCommand.copyWith(
        description: descriptionController.text,
      );
    });
    loadImages();
    super.initState();
  }

  void loadImages() async {
    for (var element in widget.productResult.images ?? []) {
      final img = await base64ToXFile(element);
      if (img != null) {
        if (productCommand.images == null || productCommand.images!.isEmpty) {
          productCommand = productCommand.copyWith(
            images: [img],
          );
        } else {
          productCommand = productCommand.copyWith(
            images: [...productCommand.images!, img],
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UpdateProductBloc>(
      create: (context) => Injector.getIt<UpdateProductBloc>(),
      child: Scaffold(
        appBar: AppBar(),
        body: BlocListener<UpdateProductBloc, UpdateProductState>(
          listener: (context, state) {
            if (state is UpdateProductLoadSuccess) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const MyHomePage(),
                ),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Form(
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 24.0),
                          child: FieldWidget(
                            codeController: codeController,
                            supplierController: supplierController,
                            yearController: yearController,
                            brandController: brandController,
                            heightController: heightController,
                            widthController: widthController,
                            depthController: depthController,
                            retailController: retailController,
                            wholesaleRetailController:
                                wholesaleRetailController,
                            wholesaleMajorController: wholesaleMajorController,
                            descriptionController: descriptionController,
                            arrayImages: widget.productResult.images,
                            images: (value) {
                              productCommand = productCommand.copyWith(
                                images: value,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                BlocBuilder<UpdateProductBloc, UpdateProductState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: state is UpdateProductInProgress
                          ? null
                          : () {
                              context
                                  .read<UpdateProductBloc>()
                                  .add(UpdateProductSaved(
                                    id: widget.productResult.id,
                                    productCommand: productCommand,
                                  ));
                            },
                      style: ButtonStyle(
                        minimumSize: const MaterialStatePropertyAll<Size>(
                          Size(350.0, 80.0),
                        ),
                        maximumSize: const MaterialStatePropertyAll<Size>(
                          Size(350.0, 80.0),
                        ),
                        backgroundColor: MaterialStatePropertyAll<Color>(
                          Colors.amber[400]!,
                        ),
                      ),
                      child: state is UpdateProductInProgress
                          ? const CircularProgressIndicator()
                          : const Text(
                              'Actualizar',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    );
                  },
                ),
                const SizedBox(height: 32.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
