import 'package:assetdash_takehome/screens/widgets/investments_cart_pie.dart';
import 'package:assetdash_takehome/screens/widgets/investments_list.dart';
import 'package:assetdash_takehome/screens/widgets/search_bar.dart';
import 'package:flutter/material.dart';

class InvestmentsScreen extends StatelessWidget {
  const InvestmentsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.background,
          title: Text('AssetsDash portfolio tracker',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              )),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchBar(
                onChange: (value) {
                  // ignore: avoid_print
                  print(value);
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text('Portfolio chart',
                    style: Theme.of(context).textTheme.labelMedium),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: InvestmentsChartPie(
                  dataMap: {
                    "Flutter": 10,
                    "React": 3,
                    "Xamarin": 2,
                    "Ionic": 2,
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text('Portfolio holdings',
                    style: Theme.of(context).textTheme.labelMedium),
              ),
              const Expanded(child: InvestmentsList())
            ],
          ),
        ));
  }
}
