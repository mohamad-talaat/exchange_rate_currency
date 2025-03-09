import 'dart:convert';
import 'package:currency_exchange_app/main.dart';
import 'package:http/http.dart' as http;
import 'package:currency_exchange_app/models/exchange_rate_model.dart';

class ExchangeService {
   static const String apiKey = '8f3a7618a2ca34eee39e72a5414205e4';
  static const String baseUrl = 'https://api.exchangerate.host';

   Future<ExchangeRateModel> getExchangeRates({
    required String startDate,  
    required String endDate,    
    required String sourceCurrency,
    String? targetCurrency,    
  }) async {
    try {
     
      final formattedStartDate = _formatDateForApi(startDate);
      final formattedEndDate = _formatDateForApi(endDate);
      
     
      final url = '$baseUrl/timeframe?start_date=$formattedStartDate&end_date=$formattedEndDate&source=$sourceCurrency&access_key=$apiKey';
      
      logger.w('Requesting URL: $url'); 
      
  
      final response = await http.get(Uri.parse(url));
      
       logger.w('Response status: ${response.statusCode}');  
       logger.w('Response body: ${response.body}');  

       if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        
       
        if (jsonData['success'] == false) {
          throw Exception('API Error: ${jsonData['error']}');
        }
        
        return ExchangeRateModel.fromJson(jsonData);
      } else {
        throw Exception('Failed to load exchange rates: ${response.statusCode}');
      }
    } catch (e) {
       logger.w('Error in getExchangeRates: $e');  
      throw Exception('Error fetching exchange rates: $e');
    }
  }
  
   ///ensure date is Format:: YYYY-MM-DD  if not Convert it >>
  String _formatDateForApi(String date) {
    /// If date is in YYYYMMDD format, convert to YYYY-MM-DD
        if (date.length == 8 && !date.contains('-')) {
      return '${date.substring(0, 4)}-${date.substring(4, 6)}-${date.substring(6, 8)}';
    }
    return date;
  }
}