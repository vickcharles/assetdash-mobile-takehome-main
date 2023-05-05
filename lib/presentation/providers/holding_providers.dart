import 'package:assetdash_takehome/data/repositories/holding_repository_imp.dart';
import 'package:assetdash_takehome/domain/entities/holding.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum HoldingStateStatus { initial, loading, data, error }

final userId = StateProvider<String>((ref) {
  return '0';
});

final selectedHolding = StateProvider<String>((ref) {
  return 'All';
});

final holdingProvider = Provider<HoldingRepositoryImp>((ref) {
  return HoldingRepositoryImp();
});

final holdingNotifierProvider = FutureProvider<List<Holding>>((ref) {
  final user = ref.watch(userId);
  final holdingsRepository = ref.watch(holdingProvider);

  return holdingsRepository.getHoldings(userId: int.parse(user));
});

final filteredHolding = FutureProvider<List<Holding>>((ref) async {
  final type = ref.watch(selectedHolding);
  final holdingsRepository = await ref.watch(holdingNotifierProvider.future);

  return type != "All"
      ? holdingsRepository.where((element) => element.type == type).toList()
      : holdingsRepository;
});
