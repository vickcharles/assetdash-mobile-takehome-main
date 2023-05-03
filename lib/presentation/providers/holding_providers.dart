import 'package:assetdash_takehome/data/repositories/holding_repository_imp.dart';
import 'package:assetdash_takehome/domain/entities/holding.dart';
import 'package:assetdash_takehome/domain/repositories/holding_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum HoldingStateStatus { initial, loading, data, error }

final holdingNotifierProvider =
    StateNotifierProvider<HoldingNotifier, HoldingState>((ref) {
  return HoldingNotifier(repository: HoldingRepositoryImp());
});

class HoldingNotifier extends StateNotifier<HoldingState> {
  final HoldingRepository repository;

  HoldingNotifier({required this.repository}) : super(HoldingState.initial()) {
    fetchHoldings(userId: 0);
  }

  Future<void> fetchHoldings({required int? userId}) async {
    state = HoldingState.loading();
    try {
      final holdings = await repository.getHoldings(userId: userId);
      state = HoldingState.data(holdings);
    } catch (e) {
      state = HoldingState.error(e.toString());
    }
  }
}

class HoldingState {
  final HoldingStateStatus status;
  final List<Holding>? holdings;
  final String? errorMessage;

  HoldingState({required this.status, this.holdings, this.errorMessage});

  factory HoldingState.initial() {
    return HoldingState(status: HoldingStateStatus.initial);
  }

  factory HoldingState.loading() {
    return HoldingState(status: HoldingStateStatus.loading);
  }

  factory HoldingState.data(List<Holding> holdings) {
    return HoldingState(status: HoldingStateStatus.data, holdings: holdings);
  }

  factory HoldingState.error(String errorMessage) {
    return HoldingState(
        status: HoldingStateStatus.error, errorMessage: errorMessage);
  }
}

final topHoldings = Provider((ref) {
  final holdings = ref.watch(holdingNotifierProvider);

  final Map<String, double> topHoldings = {
    'Others': 0,
  };

  if (holdings.holdings!.isEmpty) {
    return topHoldings;
  }

  final List<Holding> sortedHoldings = holdings.holdings!;

  sortedHoldings.sort((a, b) => b.value.compareTo(a.value));

  double totalValue = sortedHoldings.fold(
      0, (previousValue, element) => previousValue + element.value);

  for (var i = 0; i < sortedHoldings.length; i++) {
    if (i < 4) {
      double percentage = (sortedHoldings[i].value / totalValue) * 100;
      topHoldings[sortedHoldings[i].name] = percentage;
    } else {
      topHoldings['Others'] = topHoldings['Others'] == null
          ? sortedHoldings[i].value
          : topHoldings['Others']! + sortedHoldings[i].value;
    }
  }

  if (topHoldings.containsKey('Others')) {
    double percentage = (topHoldings['Others']! / totalValue) * 100;
    topHoldings['Others'] = percentage;
  }

  return topHoldings;
});
