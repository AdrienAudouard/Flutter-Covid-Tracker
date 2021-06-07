import 'package:covid_tracker/app/utils/create_sized_box.dart';
import 'package:flutter/cupertino.dart';

class IndicatorsItem extends StatelessWidget {
  final String title;
  final double value;
  final String label;
  final String? valueSuffix;

  const IndicatorsItem(this.title, this.value, this.label,
      [this.valueSuffix = '']);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                textAlign: TextAlign.center),
            getSizedBox(height: 0.5),
            Text('$value$valueSuffix',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                textAlign: TextAlign.center),
            getSizedBox(height: 0.5),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 9),
            )
          ],
        ));
  }
}
