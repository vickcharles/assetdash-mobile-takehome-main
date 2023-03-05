import 'package:assetdash_takehome/models/holding_model.mocks.dart';
import 'package:assetdash_takehome/screens/widgets/portfolio_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pie_chart/pie_chart.dart';

void main() {
  testWidgets('should display a PieChart and a legend',
      (WidgetTester tester) async {
    // Create a mock HoldingList
    final holdingList = MockHoldingList();

    // Stub the methods of the mock HoldingList
    when(holdingList.getTopHoldingsAsMap).thenReturn(
        {'AAPL': 25, 'GOOGL': 30, 'MSFT': 20, 'AMZN': 15, 'FB': 10});

    // Build the widget with the mocked HoldingList
    await tester.pumpWidget(MaterialApp(
      home: PortfolioChart(holdings: holdingList),
    ));

    // Verify that the PieChart is displayed
    expect(find.byType(PieChart), findsOneWidget);

    // Verify that the legend is displayed
    expect(find.text('AAPL'), findsOneWidget);
    expect(find.text('GOOGL'), findsOneWidget);
    expect(find.text('MSFT'), findsOneWidget);
    expect(find.text('AMZN'), findsOneWidget);
    expect(find.text('FB'), findsOneWidget);
  });

  testWidgets('should display percentage value with no decimal places',
      (WidgetTester tester) async {
    // Create a mock HoldingList
    final holdingList = MockHoldingList();

    // Stub the methods of the mock HoldingList
    when(holdingList.getTopHoldingsAsMap).thenReturn({'AAPL': 25.56});

    // Build the widget with the mocked HoldingList
    await tester.pumpWidget(MaterialApp(
      home: PortfolioChart(holdings: holdingList),
    ));

    // Verify that the percentage value is displayed with no decimal places
    expect(find.text('26%'), findsOneWidget);
  });
}
