import 'package:flutter/services.dart';

class DecimalTextInputFormatter extends TextInputFormatter {
  const DecimalTextInputFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return newValue.copyWith(
      text: newValue.text.replaceAll(',', '.'),
    );
  }
}
