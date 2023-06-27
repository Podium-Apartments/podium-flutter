import 'dart:math';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

final List<RentalData> chartData = [
  RentalData('Jan', 83706),
  RentalData('Feb', 87692),
  RentalData('Mar', 89685),
  RentalData('Apr', 92405),
  RentalData('May', 96589),
  RentalData('Jun', 99231),
  // RentalData('Jul', 4000),
  // RentalData('Aug', 4100),
  // RentalData('Sep', 4200),
  // RentalData('Oct', 4300),
  // RentalData('Nov', 4500),
  // RentalData('Dec', 5000),
];

class RentalIncomeModal extends StatelessWidget {
  const RentalIncomeModal({super.key});

  @override
  Widget build(BuildContext context) {
    final minY = chartData.map((data) => data.income).reduce(min) - 1000;
    final maxY = chartData.map((data) => data.income).reduce(max) + 1000;

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(title: AxisTitle(text: 'Months')),
                primaryYAxis: NumericAxis(
                  minimum: minY,
                  maximum: maxY,
                  interval: 2000,
                  title: AxisTitle(text: r'Rental Income in $'),
                ),
                title: ChartTitle(text: 'Monthly Rental Income'),
                legend: const Legend(isVisible: false),
                series: <ChartSeries<RentalData, String>>[
                  LineSeries<RentalData, String>(
                    dataSource: chartData,
                    xValueMapper: (RentalData rent, _) => rent.month,
                    yValueMapper: (RentalData rent, _) => rent.income,
                    name: 'Income',
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                    // Color of the line
                    color: Colors.greenAccent,

                    // Width of the line
                    width: 2,

                    // Setting the style for data labels
                    // dataLabelSettings: const DataLabelSettings(
                    //   isVisible: true,
                    //   color: Colors.black,
                    //   labelAlignment: ChartDataLabelAlignment.top,
                    //   labelPosition: ChartDataLabelPosition.outside,
                    // ),

                    // Setting the style for marker
                    markerSettings: const MarkerSettings(
                      isVisible: true,
                      height: 10,
                      width: 10,
                      shape: DataMarkerType.circle,
                      color: Colors.greenAccent,
                    ),

                    // Enable Tooltip
                    enableTooltip: true,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class RentalData {
  RentalData(this.month, this.income);

  final String month;
  final double income;
}
