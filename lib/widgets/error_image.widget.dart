import 'package:flutter/material.dart';

class ErrorImage extends StatelessWidget {
  const ErrorImage({
    super.key,
    this.width,
    this.borderRadius = const BorderRadius.only(
      topLeft: Radius.circular(15.0),
      bottomLeft: Radius.circular(15.0),
    ),
  });
  final BorderRadiusGeometry borderRadius;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280.0,
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: borderRadius,
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
  }
}
