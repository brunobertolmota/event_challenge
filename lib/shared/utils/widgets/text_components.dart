import 'package:event_challenge/shared/utils/app_colors.dart';
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

Text purpleText({required String text, required double fontSize}) {
  return Text(
    text,
    textAlign: TextAlign.center,
    style: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: fontSize,
      color: AppColors.purple,
    ),
  );
}

Text connectionStateText({required String text, required Color color}) {
  return Text(
    text,
    textAlign: TextAlign.center,
    style: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: color,
    ),
  );
}
