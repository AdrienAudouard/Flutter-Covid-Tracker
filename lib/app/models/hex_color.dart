import 'dart:ui';

class HexColor extends Color {
  final String hexColor;

  static int _getColorFromHex(String hexColor) {
    String hexColorFormatted = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColorFormatted.length == 6) {
      hexColorFormatted = 'FF$hexColorFormatted';
    }
    return int.parse(hexColorFormatted, radix: 16);
  }

  HexColor(this.hexColor) : super(_getColorFromHex(hexColor));
}