import 'package:assetdash_takehome/screens/widgets/investments_cart_pie.dart';
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
        body: Column(
          children: const [SearchBar(), InvestmentsChartPie()],
        ));
  }
}
