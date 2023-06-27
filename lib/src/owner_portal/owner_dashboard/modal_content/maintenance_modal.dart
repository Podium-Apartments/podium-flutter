import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

class MaintenanceModal extends StatelessWidget {
  const MaintenanceModal({super.key});

  @override
  Widget build(BuildContext context) {
    final chartData = [
      TaskChartData('Fixing a lightbulb', 5, 7),
      TaskChartData('Repairing the elevator', 8, 15),
      TaskChartData('Replacing a water heater', 19, 22),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 800, maxWidth: 800),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: SfCartesianChart(
                legend: const Legend(isVisible: true),
                primaryXAxis: CategoryAxis(title: AxisTitle(text: 'Tasks')),
                primaryYAxis: NumericAxis(
                  interval: 1,
                  title: AxisTitle(text: 'Days of the month'),
                ),
                series: [
                  RangeColumnSeries<TaskChartData, String>(
                    name: 'Maintenance and Repairs',
                    dataSource: chartData,
                    xValueMapper: (TaskChartData data, _) => data
                        .task, // this should map to the string (category) value
                    highValueMapper: (TaskChartData data, _) =>
                        data.high, // this should map to the numeric value
                    lowValueMapper: (TaskChartData data, _) =>
                        data.low, // this should map to the numeric value
                    pointColorMapper: (TaskChartData data, _) =>
                        data.high > 16 ? Colors.red : Colors.green,
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
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

class TaskChartData {
  TaskChartData(this.task, this.low, this.high);

  final String task;
  final double low;
  final double high;
}
