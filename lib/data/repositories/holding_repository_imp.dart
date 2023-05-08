import 'dart:convert';

import 'package:assetdash_takehome/domain/entities/holding.dart';
import 'package:assetdash_takehome/domain/repositories/holding_repository.dart';
import 'package:http/http.dart' as http;

class HoldingRepositoryImp implements HoldingRepository {
  @override
  Future<List<Holding>> getHoldings({required int? userId}) async {
    List<Holding> holdings = [];
    if (userId == null) {
      throw Exception('User ID is null');
    }
    final response = await http.get(Uri.parse(
        'https://624760d3229b222a3fcc6155.mockapi.io/api/v1/portfolio/$userId'));
    if (response.statusCode == 200) {
      var decodedJson = jsonDecode(response.body);
      if (decodedJson is Map<String, dynamic> &&
          decodedJson.containsKey('holdings')) {
        for (var holding in decodedJson['holdings']) {
          holdings.add(Holding.fromJson(holding));
        }
        return holdings;
      } else {
        throw Exception('Unexpected JSON format');
      }
    } else {
      throw Exception('Failed to load data');
    }
  }
}
