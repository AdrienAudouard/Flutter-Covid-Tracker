import 'package:covid_tracker/app/models/hex_color.dart';

class AppColors {
  static final green = HexColor('#27ae60');
  static final black = HexColor('#000000');
  static final red = HexColor('#c0392b');
  static final orange = HexColor('#e67e22');
  static final darkViolet = HexColor('#2c2c54');
  static final violet = HexColor('#7158e2');
}

HexColor getValueColor(double value) {
  final valueFixed = int.parse(value.toStringAsFixed(0));

  if (valueFixed == 0) {
    return AppColors.orange;
  } else if (valueFixed > 0) {
    return AppColors.red;
  } else {
    return AppColors.green;
  }
}

HexColor getIncidenceColor(num incidence) {
  if (incidence <= 50) {
    return AppColors.green;
  } else if (incidence <= 150) {
    return AppColors.orange;
  } else if (incidence <= 250) {
    return AppColors.red;
  } else if (incidence <= 400) {
    return AppColors.darkViolet;
  }

  return AppColors.violet;
}

String getIncidenceColorStr(num incidence) {
  return getIncidenceColor(incidence).hexColor;
}