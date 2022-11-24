import 'package:flutter/material.dart';

Text darkTitle({required String text, required double fontSize}) {
  return Text(
    text,
    textAlign: TextAlign.center,
    style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: fontSize,
      color: Colors.black,
    ),
  );
}
