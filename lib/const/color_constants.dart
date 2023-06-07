import 'package:flutter/material.dart';

// const Color primary=Color(0xff04516E);
const Color primary = Color(0xff055E80);
const Color white = Colors.white;
const Color black = Colors.black;
const Color black87 = Colors.black87;
const Color grey = Colors.grey;
Color? searchBackground = Colors.grey[200];
const Color red = Colors.red;
const Color blue = Colors.blue;
const Color errorRed = Color(0xFFAC0000);
const Color green=Color(0xFF009D49);
const Color yellow=Color(0xFFECB800);
const Color orange=Color(0xFFE35F00);
const Color bottomBarGrey=Color(0xFFF8F8F8);
const Color bottomBarInactiveIcon=Color(0xFFA0A0A0);
const Color settingAppBarBg=Color(0xFFE7F3F7);
const Color paymentSuccessAppBarBg=Color(0xFFD0F891);
const Color paymentFailedAppBarBg=Color(0xFFFDE1DD);
const Color greenContainerBg=Color(0xFFEAFFC8);


MaterialColor primaryColor = createMaterialColor(primary);

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}
