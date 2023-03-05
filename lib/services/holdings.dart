// crete get http request to get the holdings data
import 'dart:convert';

import 'package:assetdash_takehome/models/holding_model.dart';
import 'package:http/http.dart' as http;

Future<HoldingList> getHoldings({required int? userId}) async {
  if (userId == null) {
    throw Exception('User ID is null');
  }
  final response = await http.get(Uri.parse(
      'https://624760d3229b222a3fcc6155.mockapi.io/api/v1/portfolio/$userId'));
  if (response.statusCode == 200) {
    return HoldingList.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}
