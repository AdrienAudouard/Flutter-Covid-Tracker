import 'package:covid_tracker/app/models/hex_color.dart';
import 'package:covid_tracker/app/ui/shared/card.dart';
import 'package:covid_tracker/app/utils/create_sized_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SimpleDataCard extends StatelessWidget {
  final String text;
  final String value;
  final String legend;

  final HexColor? valueColor;

  const SimpleDataCard(this.text, this.value, this.legend, { this.valueColor });

  @override
  Widget build(BuildContext context) {
    return CtCard(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                text: TextSpan(
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
                    children: [
                      TextSpan(text: text),
                      TextSpan(
                          text: value,
                          style: TextStyle(color: valueColor ?? Colors.black)
                      ),
                    ]
                )
            ),
            getSizedBox(height: 1),
            Text(legend, style: Theme.of(context).textTheme.subtitle1),
          ],
        )
    );
  }

}