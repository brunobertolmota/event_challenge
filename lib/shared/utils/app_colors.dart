import 'package:flutter/material.dart';

abstract class AppColors {
  static MaterialColor eventAppPurple = 
    const MaterialColor(0xFF5732B4, <int, Color> {
      50: Color(0xffebe6f6),
      100: Color(0xffcdc2e9),
      200: Color(0xffab99da),
      300: Color(0xff8970cb),
      400: Color(0xff7051bf),
      500: Color(0xff5732b4),
      600: Color(0xff4f2dad),
      700: Color(0xff4626a4),
      800: Color(0xff3c1f9c),
      900: Color(0xff2c138c),
    });


  static const Color purple = Color.fromRGBO(112, 82, 204, 1);
  static const Color white = Color.fromRGBO(255, 255, 255, 1);
}
