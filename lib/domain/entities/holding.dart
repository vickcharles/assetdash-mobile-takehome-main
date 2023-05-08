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
}
