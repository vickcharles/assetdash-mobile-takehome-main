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
      value: double.parse(json["value"].toString()) // parse to double
      );

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
}
