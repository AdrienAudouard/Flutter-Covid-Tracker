import 'package:covid_tracker/app/utils/create_sized_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FrenchHeader extends StatelessWidget {
  final String text;


  const FrenchHeader(this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset('assets/france.svg', height: 25, width: 25),
        getSizedBox(width: 1),
        Text(text, style: Theme.of(context).textTheme.headline1, textAlign: TextAlign.left),
      ],
    );
  }
}