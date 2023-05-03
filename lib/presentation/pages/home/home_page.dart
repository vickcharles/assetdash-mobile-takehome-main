import 'package:assetdash_takehome/domain/entities/holding.dart';
import 'package:assetdash_takehome/presentation/pages/home/widgets/portfolio_chart.dart';
import 'package:assetdash_takehome/presentation/pages/home/widgets/investments_list.dart';
import 'package:assetdash_takehome/presentation/pages/home/widgets/search_bar.dart';
import 'package:assetdash_takehome/presentation/providers/holding_providers.dart';
import 'package:assetdash_takehome/widgets/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InvestmentsScreen extends ConsumerStatefulWidget {
  const InvestmentsScreen({Key? key}) : super(key: key);

  @override
  _InvestmentsScreenState createState() => _InvestmentsScreenState();
}

class _InvestmentsScreenState extends ConsumerState<InvestmentsScreen> {
  String? _selectedOption;
  final FocusNode _searchFocusNode = FocusNode();

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
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.background,
          title: Text('Portfolio tracker',
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
                    ref
                        .read(holdingNotifierProvider.notifier)
                        .fetchHoldings(userId: int.parse(value));
                  },
                  searchFocusNode: _searchFocusNode,
                ),
                // const Padding(
                //   padding: EdgeInsets.symmetric(vertical: 10),
                //   child: PortfolioChart(),
                // ),
                const HoldingList(),
              ],
            ),
          ),
        ));
  }

  Widget _buildChartSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            'Total Balance',
            style: TextStyle(
              color: Theme.of(context).colorScheme.surface,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 0),
          child: Text(
            '\$ ${0}',
            style:
                Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: 20),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Text(
            'Portfolio chart',
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: PortfolioChart(),
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
            options: [],
            selectedOption: _selectedOption,
            onChanged: (value) {
              setState(() {
                _selectedOption = value;
              });
            },
          ),
        ),
      ],
    );
  }
}

class HoldingList extends ConsumerWidget {
  const HoldingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(holdingNotifierProvider);

    return _buildBody(context, provider);
  }

  Widget _buildBody(BuildContext context, HoldingState holdingState) {
    switch (holdingState.status) {
      case HoldingStateStatus.initial:
        return const Center(child: Text('Press button to fetch holdings.'));
      case HoldingStateStatus.loading:
        return const Expanded(
            child: Center(child: CircularProgressIndicator()));
      case HoldingStateStatus.data:
        return _buildHoldinglistSection(holdingState.holdings);

      case HoldingStateStatus.error:
        return Center(child: Text('Error: ${holdingState.errorMessage}'));
      default:
        return const Center(child: Text('Unknown state'));
    }
  }

  Widget _buildChartSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            'Total Balance',
            style: TextStyle(
              color: Theme.of(context).colorScheme.surface,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 0),
          child: Text(
            '\$ ${0}',
            style:
                Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: 20),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Text(
            'Portfolio chart',
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: PortfolioChart(),
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
            options: [''],
            selectedOption: null,
            onChanged: (value) {},
          ),
        ),
      ],
    );
  }

  Widget _buildHoldinglistSection(List<Holding>? holdings) {
    return Expanded(
        child: InvestmentsList(
      holdings: holdings,
    ));
  }
}
