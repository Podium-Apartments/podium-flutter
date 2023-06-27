import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MoveOutsModal extends StatelessWidget {
  const MoveOutsModal({super.key});

  @override
  Widget build(BuildContext context) {
    final groupedData = <String, double>{
      'Jan': 4,
      'Feb': 5,
      'Mar': 3,
      'Apr': 1,
      'May': 0,
    };

    final chartData = groupedData.entries
        .map((entry) => ChartData(entry.key, entry.value))
        .toList();

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.of(context)
            .pop(); // Closes the modal when the empty area is tapped
      },
      child: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return GestureDetector(
              onTap: () {},
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints:
                      const BoxConstraints(maxHeight: 800, maxWidth: 800),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: SfCartesianChart(
                        legend: const Legend(isVisible: true),
                        primaryXAxis:
                            CategoryAxis(title: AxisTitle(text: 'Months')),
                        primaryYAxis: NumericAxis(
                          interval: 1,
                          title: AxisTitle(text: 'Move-outs per month'),
                        ),
                        series: <ChartSeries<ChartData, String>>[
                          LineSeries<ChartData, String>(
                            dataSource: chartData,
                            dataLabelSettings:
                                const DataLabelSettings(isVisible: true),

                            xValueMapper: (ChartData data, _) => data.x,
                            yValueMapper: (ChartData data, _) => data.y,

                            // Legend item text
                            legendItemText: 'Move-outs',

                            // Color of the line
                            color: Colors.redAccent,

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
                              color: Colors.redAccent,
                            ),

                            // Enable Tooltip
                            enableTooltip: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double? y;
}
