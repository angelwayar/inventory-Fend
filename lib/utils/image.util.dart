import 'dart:convert';
import 'package:flutter/services.dart';

Uint8List imageFile({required String base64Image}) {
  Uint8List bytes = base64Decode(base64Image);
  return bytes;
}
