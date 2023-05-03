import '../entities/holding.dart';

abstract class HoldingRepository {
  Future<List<Holding>> getHoldings({required int? userId});
}
