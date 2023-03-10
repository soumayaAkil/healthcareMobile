import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'chart_section.dart';
import 'indicateurs_widget.dart';

class PieChartPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PieChartPageState();
}

class PieChartPageState extends State {
  late int touchedIndex=-1;

  @override
  Widget build(BuildContext context) => Card(
    child: Column(
      children: <Widget>[
        Expanded(
          child: PieChart(
            PieChartData(
              pieTouchData: PieTouchData(
                touchCallback: (pieTouchResponse) {
                  setState(() {
                    if (pieTouchResponse.touchInput is FlLongPressEnd ||
                        pieTouchResponse.touchInput is FlPanEnd) {
                      touchedIndex = -1;
                    } else {
                      touchedIndex = pieTouchResponse.touchedSectionIndex;
                    }
                  });
                },
              ),
              borderData: FlBorderData(show: false),
              sectionsSpace: 0,
              centerSpaceRadius: 40,
              sections: getSections(touchedIndex),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: IndicatorsWidget(),
            ),
          ],
        ),
      ],
    ),
  );
}