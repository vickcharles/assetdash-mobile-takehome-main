import 'package:assetdash_takehome/domain/entities/holding.dart';
import 'package:flutter/material.dart';

class InvestmentsList extends StatelessWidget {
  final List<Holding>? holdings;

  const InvestmentsList({Key? key, required this.holdings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: holdings!.length,
      itemBuilder: (context, index) {
        final holding = holdings![index];
        return _buildListTile(context, holding);
      },
    );
  }

  Widget _buildListTile(BuildContext context, Holding holding) {
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
      trailing: Text(' \$ ${holding.value.toStringAsFixed(0)}',
          style: Theme.of(context).textTheme.labelMedium),
    );
  }
}
