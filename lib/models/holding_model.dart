class Holding {
  Holding({
    required this.ticker,
    required this.name,
    required this.type,
    required this.value,
  });

  String ticker;
  String name;
  String type;
  double value;

  factory Holding.fromJson(Map<String, dynamic> json) => Holding(
      ticker: json["ticker"],
      name: json["name"],
      type: json["type"],
      value: double.parse(json["value"].toString()));

  Map<String, dynamic> toJson() => {
        "ticker": ticker,
        "name": name,
        "type": type,
        "value": value,
      };
}

class HoldingList {
  HoldingList({
    required this.holdings,
  });

  List<Holding> holdings;

  factory HoldingList.fromJson(Map<String, dynamic> json) => HoldingList(
        holdings: List<Holding>.from(
            json["holdings"].map((x) => Holding.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "holdings": List<dynamic>.from(holdings.map((x) => x.toJson())),
      };

  Map<String, double> get getTopHoldingsAsMap {
    final Map<String, double> topHoldings = {};
    final List<Holding> sortedHoldings = holdings;
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
  }

  List<Holding> get sortedHoldings {
    final List<Holding> sortedHoldings = holdings;
    sortedHoldings.sort((a, b) => b.value.compareTo(a.value));
    return sortedHoldings;
  }
}
