import 'package:flutter/material.dart';
import 'package:podium/src/owner_portal/owner_dashboard/modal_content/move_outs_modal.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MoveInsModal extends StatelessWidget {
  const MoveInsModal({super.key});

  @override
  Widget build(BuildContext context) {
    final groupedData = <String, double>{
      'Jan': 0,
      'Feb': 1,
      'Mar': 2,
      'Apr': 4,
      'May': 7,
    };

    final chartData = groupedData.entries
        .map((entry) => ChartData(entry.key, entry.value))
        .toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 800, maxWidth: 800),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: SfCartesianChart(
                  legend: const Legend(isVisible: true),
                  primaryXAxis: CategoryAxis(title: AxisTitle(text: 'Months')),
                  primaryYAxis: NumericAxis(
                    interval: 1,
                    title: AxisTitle(text: 'Move-ins per month'),
                  ),
                  series: <ChartSeries<ChartData, String>>[
                    LineSeries<ChartData, String>(
                      dataSource: chartData,
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: true),

                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      xAxisName: 'Number of Move-ins per month',
                      yAxisName: 'Months of the year',

                      // Legend item text
                      legendItemText: 'Move-ins',

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
          ),
        );
      },
    );
  }
}
