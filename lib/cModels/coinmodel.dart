import 'dart:convert';

List<CoinMarket> coinMarketFromJson(String str) =>
    List<CoinMarket>.from(json.decode(str).map((x) => CoinMarket.fromJson(x)));

String coinMarketToJson(List<CoinMarket> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CoinMarket {
  String id;
  String symbol;
  String name;
  String image;
  double currentPrice; // Đảm bảo là double vì giá trị có thể là số thực
  double marketCapRank; // Đảm bảo là double vì giá trị có thể là số thực
  double totalVolume; // Đảm bảo là double vì giá trị có thể là số thực
  double high24H; // Đảm bảo là double
  double low24H; // Đảm bảo là double
  double priceChange24H; // Đảm bảo là double
  double marketCapChangePercentage24H; // Đảm bảo là double
  SparklineIn7D sparklineIn7D;

  CoinMarket({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.currentPrice,
    required this.marketCapRank,
    required this.totalVolume,
    required this.high24H,
    required this.low24H,
    required this.priceChange24H,
    required this.marketCapChangePercentage24H,
    required this.sparklineIn7D,
  });

  factory CoinMarket.fromJson(Map<String, dynamic> json) => CoinMarket(
    id: json["id"],
    symbol: json["symbol"],
    name: json["name"],
    image: json["image"],
    currentPrice:
        json["current_price"]?.toDouble() ?? 0.0, // Toán tử ?? giúp tránh null
    marketCapRank:
        json["market_cap_rank"]?.toDouble() ?? 0.0, // Cũng đổi thành double
    totalVolume: json["total_volume"]?.toDouble() ?? 0.0, // Đảm bảo là double
    high24H: json["high_24h"]?.toDouble() ?? 0.0, // Đảm bảo là double
    low24H: json["low_24h"]?.toDouble() ?? 0.0, // Đảm bảo là double
    priceChange24H:
        json["price_change_24h"]?.toDouble() ?? 0.0, // Đảm bảo là double
    marketCapChangePercentage24H:
        json["market_cap_change_percentage_24h"]?.toDouble() ??
        0.0, // Đảm bảo là double
    sparklineIn7D: SparklineIn7D.fromJson(json["sparkline_in_7d"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "symbol": symbol,
    "name": name,
    "image": image,
    "current_price": currentPrice,
    "market_cap_rank": marketCapRank,
    "total_volume": totalVolume,
    "high_24h": high24H,
    "low_24h": low24H,
    "price_change_24h": priceChange24H,
    "market_cap_change_percentage_24h": marketCapChangePercentage24H,
    "sparkline_in_7d": sparklineIn7D.toJson(),
  };
}

class SparklineIn7D {
  List<double> price;

  SparklineIn7D({required this.price});

  factory SparklineIn7D.fromJson(Map<String, dynamic> json) => SparklineIn7D(
    price: List<double>.from(
      json["price"].map((x) => x?.toDouble() ?? 0.0),
    ), // Kiểm tra và chuyển sang double
  );

  Map<String, dynamic> toJson() => {
    "price": List<dynamic>.from(price.map((x) => x)),
  };
}
