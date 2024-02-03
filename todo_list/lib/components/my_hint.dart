import 'package:flutter/material.dart';

import '../utils/my_style.dart';

class MyHint extends StatelessWidget {
  final String title;

  const MyHint({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        title,
        style: const TextStyle(
          color: myGold,
          fontSize: 15.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
