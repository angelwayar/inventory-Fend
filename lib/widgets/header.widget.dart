import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      margin: const EdgeInsets.only(bottom: 24.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24.0),
          bottomRight: Radius.circular(24.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 1,
            spreadRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 24.0),
          ClipRRect(
            borderRadius: BorderRadius.circular(24.0),
            child: Image.asset(
              'assets/logo.png',
              width: 120,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 24.0),
          Text(
            'Inventario',
            style: TextStyle(
              fontSize: 32.0,
              color: Colors.deepPurple[500],
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
