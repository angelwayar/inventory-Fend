import 'package:flutter/material.dart';

import 'popup_image.widget.dart';

Future<T?> customShowDialog<T extends Object>({
  required BuildContext context,
  String? title,
  String? description,
  List<String>? images,
  double height = 120.0,
  double width = 120.0,
}) async {
  return showDialog<T>(
    useSafeArea: true,
    context: context,
    builder: (context) {
      return Material(
        type: MaterialType.transparency,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 200.0),
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: PopUpImageWidget(images: images)),
              const SizedBox(height: 12.0),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Cerrar',
                  style: TextStyle(fontSize: 24.0),
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
