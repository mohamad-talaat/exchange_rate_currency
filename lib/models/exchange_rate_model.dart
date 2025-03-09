

///Class Model From Json ::Example API Response
class ExchangeRateModel {
  final bool success;
  final String? terms;
  final String? privacy;
  final bool? timeframe;
  final String? source;
  final Map<String, Map<String, double>> quotes;
  final Map<String, dynamic>? error;

  ExchangeRateModel({
    required this.success,
    this.terms,
    this.privacy,
    this.timeframe,
    this.source,
    required this.quotes,
    this.error,
  });

  factory ExchangeRateModel.fromJson(Map<String, dynamic> json) {
    if (json['success'] == false) {
      return ExchangeRateModel(
        success: false,
        quotes: {},
        error: json['error'] as Map<String, dynamic>?,
      );
    }

    /// Convert the quotes into  map >> to display the table Ex. Rate  
    Map<String, Map<String, double>> quotesMap = {};

    if (json['quotes'] != null) {
      (json['quotes'] as Map<String, dynamic>).forEach((date, currencies) {
        Map<String, double> currencyMap = {};
        (currencies as Map<String, dynamic>).forEach((currencyCode, rate) {
          currencyMap[currencyCode] = rate is int ? rate.toDouble() : rate;
        });
        quotesMap[date] = currencyMap;
      });
    }

    return ExchangeRateModel(
      success: json['success'] ?? false,
      terms: json['terms'],
      privacy: json['privacy'],
      timeframe: json['timeframe'],
      source: json['source'],
      quotes: quotesMap,
    );
  }
}

class ExchangeRateRecord {
  final String date;
  final String sourceCurrency;
  final String targetCurrency;
  final double rate;

  ExchangeRateRecord({
    required this.date,
    required this.sourceCurrency,
    required this.targetCurrency,
    required this.rate,
  });
}
