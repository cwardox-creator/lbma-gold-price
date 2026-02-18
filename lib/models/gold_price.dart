class GoldPrice {
  final String date;
  final double? usd;
  final double? gbp;
  final double? eur;

  GoldPrice({required this.date, this.usd, this.gbp, this.eur});

  factory GoldPrice.fromJson(Map<String, dynamic> json) {
    final v = json['v'] as List<dynamic>?;
    return GoldPrice(
      date: json['d'] as String,
      usd: v != null && v.isNotEmpty ? (v[0] as num?)?.toDouble() : null,
      gbp: v != null && v.length > 1 ? (v[1] as num?)?.toDouble() : null,
      eur: v != null && v.length > 2 ? (v[2] as num?)?.toDouble() : null,
    );
  }

  double? priceForCurrency(int index) {
    switch (index) {
      case 0: return usd;
      case 1: return gbp;
      case 2: return eur;
      default: return usd;
    }
  }
}

class GoldDayData {
  final String date;
  final GoldPrice? am;
  final GoldPrice? pm;
  GoldDayData({required this.date, this.am, this.pm});
}
