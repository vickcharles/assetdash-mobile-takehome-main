import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class InvestmentsChartPie extends StatelessWidget {
  final Map<String, double> dataMap = const {
    "Flutter": 10,
    "React": 3,
    "Xamarin": 2,
    "Ionic": 2,
  };

  const InvestmentsChartPie({Key? key}) : super(key: key);

  final List<Color> _colorList = const [
    Color(0xFFef6461),
    Color(0xFF4E44CE),
    Color(0xFFFFC857),
    Color(0xFF21ce9a),
    Color(0xFF56AEE2),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          PieChart(
            dataMap: dataMap,
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
            width: 20.0,
          ),
          Expanded(child: _buildLegendOptions(context)),
        ],
      ),
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
                  Text(
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

    return Column(
      children: [
        Column(children: [
          _buildLegendItem('Flutter', _colorList[0], 100),
          _buildLegendItem('Flutter', _colorList[1], 200),
          _buildLegendItem('Flutter', _colorList[2], 300),
          _buildLegendItem('Flutter', _colorList[3], 400),
        ])
      ],
    );
  }
}
