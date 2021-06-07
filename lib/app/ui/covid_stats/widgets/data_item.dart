import 'package:covid_tracker/app/models/hex_color.dart';
import 'package:covid_tracker/app/utils/create_sized_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class DataItem extends StatelessWidget {
  final String label;
  final num value;
  final String valueSuffix;
  final String valuePrefix;
  final HexColor valueColor;

  const DataItem(this.label, this.value, this.valueColor, { this.valueSuffix = '', this.valuePrefix = '' });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
          getSizedBox(height: 0.5),
          Text('$valuePrefix${value.toStringAsFixed(0)}$valueSuffix', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: valueColor))
        ]),
    );
  }
}