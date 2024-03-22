import 'package:flutter/material.dart';

import 'pages/home.page.dart';
import 'utils/materialScrollBeavior.util.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: AppScrollBehavior(),
      home: const MyHomePage(),
    );
  }
}
