import 'package:flutter/material.dart';
import 'package:inventory_fend/app.dart';

import 'injection.dart';

void main() {
  Injector().initInjector();
  runApp(const MyApp());
}
