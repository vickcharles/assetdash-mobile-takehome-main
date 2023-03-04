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
    try {
      setState(() {
        _loading = true;
      });
      final holdingList = await getHoldings(userId: 0);
      setState(() {
        _holdingList = holdingList;
      });
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

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
                  setState(() {
                    userId = value;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text('Portfolio chart',
                    style: Theme.of(context).textTheme.labelMedium),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: InvestmentsChartPie(
                  holdings: _holdingList.holdings,
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
