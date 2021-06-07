import 'package:covid_tracker/app/models/hex_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CtCard extends StatelessWidget {
  final Widget child;

  const CtCard(this.child);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: HexColor('#ffffff'),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child
    );
  }

}