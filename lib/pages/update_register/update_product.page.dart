import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_fend/models/models.dart';
import 'package:inventory_fend/pages/register/fields.dart';

import '../../blocs/blocs.dart';
import '../../injection.dart';
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
      text: productCommand.height.toString(),
    );
    widthController = TextEditingController(
      text: productCommand.width.toString(),
    );
    depthController = TextEditingController(
      text: productCommand.depth.toString(),
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
    descriptionController.addListener(() {
      productCommand = productCommand.copyWith(
        description: descriptionController.text,
      );
    });
    super.initState();
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
                            descriptionController: descriptionController,
                            arrayImages: widget.productResult.images,
                            images: (value) {
                              productCommand =
                                  productCommand.copyWith(images: value);
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
                      style: const ButtonStyle(
                        minimumSize: MaterialStatePropertyAll<Size>(
                          Size(350.0, 80.0),
                        ),
                        maximumSize: MaterialStatePropertyAll<Size>(
                          Size(350.0, 80.0),
                        ),
                      ),
                      child: state is UpdateProductInProgress
                          ? const CircularProgressIndicator()
                          : const Text(
                              'Actualizar',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
