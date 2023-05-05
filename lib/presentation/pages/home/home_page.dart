import 'package:assetdash_takehome/domain/entities/holding.dart';
import 'package:assetdash_takehome/presentation/pages/home/widgets/portfolio_chart.dart';
import 'package:assetdash_takehome/presentation/pages/home/widgets/investments_list.dart';
import 'package:assetdash_takehome/presentation/pages/home/widgets/search_bar.dart';
import 'package:assetdash_takehome/presentation/providers/holding_providers.dart';
import 'package:assetdash_takehome/presentation/widgets/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InvestmentsScreen extends ConsumerStatefulWidget {
  const InvestmentsScreen({Key? key}) : super(key: key);

  @override
  _InvestmentsScreenState createState() => _InvestmentsScreenState();
}

class _InvestmentsScreenState extends ConsumerState<InvestmentsScreen> {
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
    final holding = ref.watch(filteredHolding);

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.background,
          title: const Text("Portfolio"),
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
                      if (value == '') return;
                      ref.read(userId.notifier).state = value;
                    },
                    searchFocusNode: _searchFocusNode,
                  ),
                  holding.when(
                      data: (data) =>
                          Expanded(child: _buildHoldingsSection(data)),
                      error: (e, a) => const Text('asdsa'),
                      loading: () => const Padding(
                            padding: EdgeInsets.only(top: 50),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ))
                ],
              )),
        ));
  }

  Column _buildHoldingsSection(List<Holding> holdings) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: PortfolioChart(
          holdings: holdings,
        ),
      ),
      HoldingDropdownButton(),
      Expanded(
        child: InvestmentsList(
          holdings: holdings,
        ),
      ),
    ]);
  }
}

class HoldingDropdownButton extends ConsumerWidget {
  HoldingDropdownButton({Key? key}) : super(key: key);

  List<String> types(List<Holding> holdings) {
    List<String> types = ['All'];
    for (var i = 0; i < holdings.length; i++) {
      types.add(holdings[i].type);
    }
    return types.toSet().toList();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String selected = ref.watch(selectedHolding);
    final holding = ref.watch(holdingNotifierProvider);
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
            child: holding.when(
                data: (data) => CustomDropdownButton(
                      options: types(data),
                      selectedOption: selected,
                      onChanged: (value) {
                        ref.read(selectedHolding.notifier).state = value;
                      },
                    ),
                error: (error, stackTrace) => const Text('error'),
                loading: () => const Text('loading'))),
      ],
    );
  }
}
