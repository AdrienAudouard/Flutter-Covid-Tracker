import 'package:covid_tracker/app/models/daily_stats/daily_cases_model.dart';
import 'package:covid_tracker/app/ui/shared/card.dart';
import 'package:covid_tracker/app/utils/create_sized_box.dart';
import 'package:covid_tracker/app/utils/utils_func.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DailyCasesGraph extends StatelessWidget {
  final List<Color> gradientColors;

  final DailyValues dailyValues;
  final String title;
  final int yStep;
  final String legend;

  const DailyCasesGraph(
      this.dailyValues,
      this.title,
      {
        this.legend = '',
        this.yStep = 1000,
        this.gradientColors = const [
          Color(0xff23b6e6),
          Color(0xff02d39a),
        ]
      });

  @override
  Widget build(BuildContext context) {
    return CtCard(
        buildWidget(context, dailyValues)
    );
  }

  Widget buildWidget(BuildContext context, DailyValues dailyValues) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 16),
          child: Text(title, style: Theme.of(context).textTheme.headline3),
        ),
        getSizedBox(height: 2),
        buildGraphContainer(dailyValues),
        getSizedBox(height: 2),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Text(legend, style: Theme.of(context).textTheme.subtitle1),
        ),
      ],
    );
  }

  Widget buildGraphContainer(DailyValues dailyValues) {
    return AspectRatio(
      aspectRatio: 1.70,
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(18),
            )),
        child: Padding(
          padding: const EdgeInsets.only(right: 18.0, left: 12.0, bottom: 12),
          child: LineChart(mainData(dailyValues))
          ),
        )
    );
  }

  LineChartData mainData(DailyValues dailyValues) {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: value % yStep == 0 ? 1 : 0,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) =>
          const TextStyle(color: Color(0xff68737d), fontWeight: FontWeight.bold, fontSize: 16),
          getTitles: (value) {
            final index = value.toInt() - 1;
            final max = dailyValues.values.length - 1;
            final mid = max ~/ 2;

            if (index == 0 || index == mid || index == max) {
              return toShortDate(dailyValues.dates[index]);
            }

            return '';

          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            if (value % yStep == 0) {
              final _formattedNumber = NumberFormat.compact().format(value);
              return _formattedNumber.toString();
            }

            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: const Border(
              left: BorderSide(color: Color(0xff37434d)),
              bottom: BorderSide(color: Color(0xff37434d)),
          )),
      minX: 0,
      maxX: dailyValues.values.length.toDouble(),
      minY: 0,
      maxY: getMaxX(dailyValues) * 1.1,
      lineBarsData: [
        LineChartBarData(
          spots: getFlSpot(dailyValues),
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors: gradientColors.map((color) => color.withOpacity(0.5)).toList(),
          ),
        ),
      ],
    );
  }

  List<FlSpot> getFlSpot(DailyValues dailyValues) {
    return dailyValues.values
        .asMap()
        .entries
        .map((it) => FlSpot(it.key.toDouble(), it.value.toDouble()))
        .toList();
  }

  double getMaxX(DailyValues dailyValues) {
    int max = 0;

    dailyValues.values.forEach((element) {
      if (element > max) {
        max = element;
      }
    });

    return max.toDouble();
  }
}