import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_fend/models/models.dart';
import 'package:inventory_fend/pages/register/fields.dart';

import '../../blocs/blocs.dart';
import '../../injection.dart';
import '../home.page.dart';

class RegisterProductPage extends StatefulWidget {
  const RegisterProductPage({super.key});

  @override
  State<RegisterProductPage> createState() => _RegisterProductPageState();
}

class _RegisterProductPageState extends State<RegisterProductPage> {
  late ProductCommand productCommand;
  final codeController = TextEditingController();
  final supplierController = TextEditingController();
  final yearController = TextEditingController();
  final brandController = TextEditingController();
  final heightController = TextEditingController();
  final widthController = TextEditingController();
  final depthController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    productCommand = const ProductCommand(
      code: null,
      supplier: null,
      description: null,
      year: null,
      height: null,
      width: null,
      depth: null,
      retail: null,
      images: null,
      brand: null,
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
    return BlocProvider<RegisterProductBloc>(
      create: (context) => Injector.getIt<RegisterProductBloc>(),
      child: Scaffold(
        appBar: AppBar(),
        body: BlocListener<RegisterProductBloc, RegisterProductState>(
          listener: (context, state) {
            if (state is RegisterProductLoadSuccess) {
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
                BlocBuilder<RegisterProductBloc, RegisterProductState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: state is RegisterProductInProgress
                          ? null
                          : () {
                              context
                                  .read<RegisterProductBloc>()
                                  .add(RegisterProductSaved(
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
                      child: state is RegisterProductInProgress
                          ? const CircularProgressIndicator()
                          : const Text(
                              'Registrar',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                    );
                  },
                ),
                const SizedBox(height: 24.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
