import 'package:assetdash_takehome/models/holding_model.dart';
import 'package:assetdash_takehome/screens/widgets/portfolio_chart.dart';
import 'package:assetdash_takehome/screens/widgets/investments_list.dart';
import 'package:assetdash_takehome/screens/widgets/search_bar.dart';
import 'package:assetdash_takehome/services/holdings.dart';
import 'package:assetdash_takehome/widgets/dropdown.dart';
import 'package:flutter/material.dart';

class InvestmentsScreen extends StatefulWidget {
  const InvestmentsScreen({Key? key}) : super(key: key);

  @override
  State<InvestmentsScreen> createState() => _InvestmentsScreenState();
}

class _InvestmentsScreenState extends State<InvestmentsScreen> {
  bool _loading = false;
  String? _userId;
  String? _selectedOption;
  late List<String> _options = [];
  final _searchFocusNode = FocusNode();
  HoldingList _holdingList = HoldingList(holdings: []);

  @override
  void initState() {
    super.initState();
    _fetchHoldings();
  }

  Future _fetchHoldings({String? type}) async {
    if (_userId == null) return;
    try {
      setState(() {
        _loading = true;
      });
      final holdingList = await getHoldings(userId: int.parse(_userId!));
      _options = holdingList.types;
      setState(() {
        _holdingList = type == null || type == 'All'
            ? holdingList
            : holdingList.filterHoldingsByType(type);
      });
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _handleScreenTap() {
    _searchFocusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final widgets = <Widget>[
      _buildChartSection(context),
      _buildHoldingsSection(context),
      _buildHoldinglistSection(context),
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
        body: GestureDetector(
          onTap: _handleScreenTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchBar(
                  onChange: (value) {
                    setState(() {
                      _userId = value.isEmpty ? null : value;
                      _selectedOption = null;
                    });
                    _fetchHoldings();
                  },
                  searchFocusNode: _searchFocusNode,
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
          ),
        ));
  }

  Widget _buildChartSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Text(
            'Portfolio chart',
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: PortfolioChart(
            holdings: _holdingList,
          ),
        ),
      ],
    );
  }

  Widget _buildHoldingsSection(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Text(
              'Portfolio holdings',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: CustomDropdownButton(
            options: _options,
            selectedOption: _selectedOption,
            onChanged: (value) {
              setState(() {
                _selectedOption = value;
              });

              _fetchHoldings(type: value);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHoldinglistSection(BuildContext context) {
    return Expanded(
        child: InvestmentsList(
      holdings: _holdingList,
    ));
  }
}
