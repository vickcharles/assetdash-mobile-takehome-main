import 'package:assetdash_takehome/models/holding_model.dart';
import 'package:assetdash_takehome/screens/widgets/investments_cart_pie.dart';
import 'package:assetdash_takehome/screens/widgets/investments_list.dart';
import 'package:assetdash_takehome/screens/widgets/search_bar.dart';
import 'package:assetdash_takehome/services/holdings.dart';
import 'package:flutter/material.dart';

class InvestmentsScreen extends StatefulWidget {
  const InvestmentsScreen({Key? key}) : super(key: key);

  @override
  State<InvestmentsScreen> createState() => _InvestmentsScreenState();
}

class _InvestmentsScreenState extends State<InvestmentsScreen> {
  bool _loading = false;
  String? userId;
  HoldingList _holdingList = HoldingList(holdings: []);

  @override
  void initState() {
    super.initState();
    _fetchHoldings();
  }

  Future _fetchHoldings() async {
    if (userId == null) return;
    try {
      setState(() {
        _loading = true;
      });
      final holdingList = await getHoldings(userId: int.parse(userId!));
      setState(() {
        _holdingList = holdingList;
      });
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final widgets = <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Text('Portfolio chart',
            style: Theme.of(context).textTheme.labelMedium),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: InvestmentsChartPie(
          holdings: _holdingList,
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Text('Portfolio holdings',
            style: Theme.of(context).textTheme.labelMedium),
      ),
      Expanded(
          child: InvestmentsList(
        holdings: _holdingList,
      ))
    ];
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.background,
          title: Text('AssetsDash portfolio tracker',
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: Theme.of(context).colorScheme.primary)),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchBar(
                onChange: (value) {
                  setState(() {
                    userId = value.isEmpty ? null : value;
                  });
                  _fetchHoldings();
                },
              ),
              if (_loading)
                const Expanded(
                    child: Center(child: CircularProgressIndicator()))
              else if (_holdingList.holdings.isEmpty)
                Expanded(
                    child: Center(
                        child: Text('No holdings found 📭',
                            style: Theme.of(context).textTheme.labelMedium)))
              else
                ...widgets
            ],
          ),
        ));
  }
}
