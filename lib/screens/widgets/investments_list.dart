import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InvestmentsList extends StatelessWidget {
  const InvestmentsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, int) {
      return ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 0),
        title: Text(
          'APPLE',
          style: Theme.of(context).textTheme.labelMedium,
        ),
        subtitle: Text(
          'sds',
          style: Theme.of(context).textTheme.headline6,
        ),
        trailing: Text('100', style: Theme.of(context).textTheme.labelMedium),
      );
    });
  }
}
