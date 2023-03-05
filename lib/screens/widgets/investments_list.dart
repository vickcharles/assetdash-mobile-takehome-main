import 'package:assetdash_takehome/models/holding_model.dart';
import 'package:flutter/material.dart';

class InvestmentsList extends StatelessWidget {
  final HoldingList holdings;

  const InvestmentsList({Key? key, required this.holdings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: holdings.sortedHoldings.length,
      itemBuilder: (context, index) {
        final holding = holdings.sortedHoldings[index];
        return _buildListTile(context, holding);
      },
    );
  }

  Widget _buildListTile(BuildContext context, Holding holding) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        holding.name,
        style: Theme.of(context).textTheme.bodyText2,
      ),
      subtitle: Text(
        holding.ticker,
        style: Theme.of(context).textTheme.subtitle1,
      ),
      trailing: Text(
        holding.value.toStringAsFixed(0),
        style: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }
}
