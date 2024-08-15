class Stock {
  final String ticker;
  final double open;
  final double close;
  final double high;
  final double low;
  final int vol;
  final String date;

  Stock({
    required this.ticker,
    required this.open,
    required this.close,
    required this.high,
    required this.low,
    required this.vol,
    required this.date,
  });

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      ticker: json['ticker'],
      open: (json['open'] as num).toDouble(), 
      close: (json['close'] as num).toDouble(),
      high: (json['high'] as num).toDouble(),
      low: (json['low'] as num).toDouble(),
      vol: (json['vol'] as num).toInt(),
      date: json['date'],
    );
  }
}
