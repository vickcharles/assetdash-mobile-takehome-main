import 'package:assetdash_takehome/domain/entities/holding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pie_chart/pie_chart.dart';

class PortfolioChart extends ConsumerWidget {
  final List<Holding> holdings;
  const PortfolioChart({Key? key, required this.holdings}) : super(key: key);

  final List<Color> _colorList = const [
    Color(0xFFef6461),
    Color(0xFF4E44CE),
    Color(0xFFFFC857),
    Color(0xFF21ce9a),
    Color(0xFF56AEE2),
  ];

  Map<String, double> get getTopHoldingsAsMap {
    final Map<String, double> topHoldings = {};

    holdings.sort((a, b) => b.value.compareTo(a.value));

    double totalValue = holdings.fold(
        0, (previousValue, element) => previousValue + element.value);

    for (var i = 0; i < holdings.length; i++) {
      if (i < 4) {
        double percentage = (holdings[i].value / totalValue) * 100;
        topHoldings[holdings[i].name] = percentage;
      } else {
        topHoldings['Others'] = topHoldings['Others'] == null
            ? holdings[i].value
            : topHoldings['Others']! + holdings[i].value;
      }
    }

    if (topHoldings.containsKey('Others')) {
      double percentage = (topHoldings['Others']! / totalValue) * 100;
      topHoldings['Others'] = percentage;
    }

    return topHoldings;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        PieChart(
          dataMap: getTopHoldingsAsMap,
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
        Expanded(child: _buildLegendOptions(context))
      ],
    );
  }

  Widget _buildLegendOptions(BuildContext context) {
    Widget _buildLegendItem(String label, Color color, double value) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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
      var keysList = getTopHoldingsAsMap.keys.toList();
      List<Widget> widgets = [];

      getTopHoldingsAsMap.forEach((key, value) {
        widgets.add(
            _buildLegendItem(key, _colorList[keysList.indexOf(key)], value));
      });

      return widgets;
    }

    return Column(
      children: [
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: buildWidgets())
      ],
    );
  }
}
