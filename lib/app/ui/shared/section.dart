import 'package:covid_tracker/app/utils/create_sized_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Section extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Widget> children;
  final double? spaceBetween;

  const Section(this.title, this.subtitle, this.children, {this.spaceBetween = 20});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.headline2),
        getSizedBox(height: 1),
        Text(subtitle, style: Theme.of(context).textTheme.subtitle1),
        getSizedBox(height: 2),
        ...buildChildren()
      ],
    );
  }

  List<Widget> buildChildren() {
    final newChildren = <Widget>[];

    children.forEach((child) {
      newChildren.add(child);
      newChildren.add(SizedBox(height: spaceBetween));
    });

    return newChildren;
  }
}