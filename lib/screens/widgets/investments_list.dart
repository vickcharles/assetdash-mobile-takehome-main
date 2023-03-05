import 'package:assetdash_takehome/models/holding_model.dart';
import 'package:flutter/material.dart';

class InvestmentsList extends StatelessWidget {
  final HoldingList holdings;
  const InvestmentsList({Key? key, required this.holdings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: holdings.sortedHoldings.length,
        itemBuilder: (context, int) {
          Holding holding = holdings.sortedHoldings[int];
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 0),
            title: Text(
              holding.name,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            subtitle: Text(
              holding.ticker,
              style: Theme.of(context).textTheme.headline6,
            ),
            trailing: Text(holding.value.toStringAsFixed(0),
                style: Theme.of(context).textTheme.labelMedium),
          );
        });
  }
}
