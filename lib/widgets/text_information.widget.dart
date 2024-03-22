import 'package:flutter/material.dart';

class TextInformationWidget extends StatelessWidget {
  const TextInformationWidget({
    super.key,
    required this.label,
    required this.text,
  });

  final String label;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 12.0),
        Flexible(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w400,
              overflow: TextOverflow.ellipsis,
            ),
            maxLines: 5,
          ),
        ),
      ],
    );
  }
}
