import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class FinancialChart extends StatelessWidget {
  final List<FlSpot> data;

  FinancialChart({required this.data});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(
        //  leftTitles: SideTitles(showTitles: true),
         // bottomTitles: SideTitles(showTitles: true),
        ),
        borderData: FlBorderData(
          show: true,
        ),
        minX: 0,
        maxX: data.length.toDouble() - 1,
        minY: 0,
        maxY: _findMaxY(data), // Calculate the appropriate maximum Y value
        lineBarsData: [
          LineChartBarData(
            spots: data,
            isCurved: true,
            color: Colors.blue,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(show: false),
          ),
        ],
      ),
    );
  }

  double _findMaxY(List<FlSpot> data) {
    double max = 0;
    for (final spot in data) {
      if (spot.y > max) {
        max = spot.y;
      }
    }
    return max;
  }
}
