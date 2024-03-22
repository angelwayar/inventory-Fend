import 'package:flutter/material.dart';

class PaginationWidget extends StatelessWidget {
  const PaginationWidget({
    super.key,
    required this.length,
    required this.indexSelected,
    this.height = 12.0,
    this.width = 12.0,
    this.colorNotSelected = Colors.grey,
    this.colorSelected = Colors.deepPurple,
  });

  final int length;
  final double width;
  final double height;
  final int indexSelected;
  final Color colorSelected;
  final Color colorNotSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(length, (index) {
        return Container(
          height: height,
          width: width,
          margin: const EdgeInsets.symmetric(horizontal: 6.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index == indexSelected ? colorSelected : colorNotSelected,
          ),
        );
      }),
    );
  }
}
