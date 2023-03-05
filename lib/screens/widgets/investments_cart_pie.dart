import 'package:assetdash_takehome/models/holding_model.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class InvestmentsChartPie extends StatelessWidget {
  final HoldingList holdings;

  const InvestmentsChartPie({Key? key, required this.holdings})
      : super(key: key);

  final List<Color> _colorList = const [
    Color(0xFFef6461),
    Color(0xFF4E44CE),
    Color(0xFFFFC857),
    Color(0xFF21ce9a),
    Color(0xFF56AEE2),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        PieChart(
          dataMap: holdings.getTopHoldingsAsMap,
          animationDuration: const Duration(milliseconds: 800),
          chartLegendSpacing: 20,
          chartRadius: MediaQuery.of(context).size.width / 3.5,
          colorList: _colorList,
          chartType: ChartType.ring,
          ringStrokeWidth: 25,
          chartValuesOptions: const ChartValuesOptions(
            showChartValueBackground: false,
            showChartValues: false,
            showChartValuesInPercentage: false,
            showChartValuesOutside: false,
          ),
          legendOptions: const LegendOptions(
            showLegendsInRow: false,
            showLegends: false,
            legendPosition: LegendPosition.right,
          ),
        ),
        const SizedBox(
          width: 30.0,
        ),
        Expanded(child: _buildLegendOptions(context)),
      ],
    );
  }

  Widget _buildLegendOptions(BuildContext context) {
    Widget _buildLegendItem(String label, Color color, double value) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  const SizedBox(width: 10),
                  label.length > 10
                      ? Text(
                          '${label.substring(0, 10)}...',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        )
                      : Text(
                          label,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ),
                ],
              ),
              Text(
                '${value.toStringAsFixed(0)}%',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
            ]),
      );
    }

    List<Widget> buildWidgets() {
      var keysList = holdings.getTopHoldingsAsMap.keys.toList();
      List<Widget> widgets = [];

      holdings.getTopHoldingsAsMap.forEach((key, value) {
        widgets.add(
            _buildLegendItem(key, _colorList[keysList.indexOf(key)], value));
      });

      return widgets;
    }

    return Column(
      children: [Column(children: buildWidgets())],
    );
  }
}
