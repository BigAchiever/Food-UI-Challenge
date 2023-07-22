import 'package:flutter/material.dart';

class AppTheme {
  static const Color pricetagcolor = Color(0xffFFB942);
  static List<Color> cardColors = [
    const Color(0xffFFC43A),
    Colors.pink,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.yellow,
    Colors.indigo,
  ];

  static Color getCardColor(int index) {
    return cardColors[index % cardColors.length];
  }
}
