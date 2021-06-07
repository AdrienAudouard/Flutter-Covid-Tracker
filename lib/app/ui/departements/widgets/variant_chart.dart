import 'package:covid_tracker/app/models/hex_color.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class VariantChart extends StatelessWidget {
  final double variantUk;
  final double variantBz;
  final double otherVariants;


  const VariantChart(this.variantUk, this.variantBz, this.otherVariants);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.7,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 120,
          barTouchData: BarTouchData(
            enabled: false,
            touchTooltipData: BarTouchTooltipData(
              tooltipBgColor: Colors.transparent,
              tooltipPadding: const EdgeInsets.all(0),
              tooltipMargin: 8,
              getTooltipItem: (
                  BarChartGroupData group,
                  int groupIndex,
                  BarChartRodData rod,
                  int rodIndex,
                  ) {
                return BarTooltipItem(
                  '${rod.y.round().toString()} %',
                  const TextStyle(color: Colors.black, fontWeight: FontWeight.bold,),
                );
              },
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: SideTitles(
              showTitles: true,
              getTextStyles: (value) => const TextStyle(
                  color: Color(0xff7589a2), fontWeight: FontWeight.bold, fontSize: 14),
              margin: 20,
              getTitles: (double value) {
                switch (value.toInt()) {
                  case 0:
                    return AppLocalizations.of(context)!.pageDepartementVariantUk;
                  case 1:
                    return AppLocalizations.of(context)!.pageDepartementVariantBz;
                  case 2:
                    return AppLocalizations.of(context)!.pageDepartementVariantOther;
                  default:
                    return '';
                }
              },
            ),
            leftTitles: SideTitles(showTitles: false),
          ),
          borderData: FlBorderData(
            show: false,
          ),
          barGroups: [
            buildBarChartData(variantUk, 0),
            buildBarChartData(variantBz, 1),
            buildBarChartData(otherVariants, 2),
          ],
        ),
      ),
    );
  }

  BarChartGroupData buildBarChartData(double value, int x) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(y: value, colors: [HexColor('#1565C0'), HexColor('#b92b27')], width: 10)
      ],
      showingTooltipIndicators: [0],
    );
  }
}