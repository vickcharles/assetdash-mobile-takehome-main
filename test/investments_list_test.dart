import 'package:assetdash_takehome/models/holding_model.dart';
import 'package:assetdash_takehome/screens/widgets/investments_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('InvestmentsList displays holdings correctly',
      (WidgetTester tester) async {
    // Create some sample Holding data to display in the InvestmentsList
    final holding1 = Holding(
        ticker: 'AAPL', name: 'Apple Inc.', value: 10000.0, type: 'stock');
    final holding2 = Holding(
        ticker: 'AMZN', name: 'Amazon.com, Inc.', value: 5000.0, type: 'stock');
    final holding3 = Holding(
        ticker: 'GOOG', name: 'Alphabet Inc.', value: 7500.0, type: 'stock');
    final holding4 = Holding(
        ticker: 'MSFT',
        name: 'Microsoft Corporation',
        value: 3000.0,
        type: 'stock');

    final holdings =
        HoldingList(holdings: [holding1, holding2, holding3, holding4]);

    // Build the InvestmentsList widget with the sample Holding data
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: InvestmentsList(holdings: holdings),
        ),
      ),
    );

    // Verify that the InvestmentList displays each Holding's name, ticker, and value
    expect(find.text(holding1.name), findsOneWidget);
    expect(find.text(holding1.ticker), findsOneWidget);
    expect(find.text(holding1.value.toStringAsFixed(0)), findsOneWidget);

    expect(find.text(holding2.name), findsOneWidget);
    expect(find.text(holding2.ticker), findsOneWidget);
    expect(find.text(holding2.value.toStringAsFixed(0)), findsOneWidget);

    expect(find.text(holding3.name), findsOneWidget);
    expect(find.text(holding3.ticker), findsOneWidget);
    expect(find.text(holding3.value.toStringAsFixed(0)), findsOneWidget);

    expect(find.text(holding4.name), findsOneWidget);
    expect(find.text(holding4.ticker), findsOneWidget);
    expect(find.text(holding4.value.toStringAsFixed(0)), findsOneWidget);
  });
}
