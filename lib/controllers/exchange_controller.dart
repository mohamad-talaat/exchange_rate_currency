import 'package:currency_exchange_app/main.dart';
import 'package:currency_exchange_app/models/exchange_rate_model.dart';
import 'package:currency_exchange_app/services/exchange_service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ExchangeController extends GetxController {
  final ExchangeService _exchangeService = ExchangeService();

 
  var isLoading = false.obs;
  var hasError = false.obs;
  var errorMessage = ''.obs;

  var exchangeRateRecords = <ExchangeRateRecord>[].obs;

 
  var currentPage = 0.obs;
  var itemsPerPage = 10;
  var totalPages = 0.obs;

   //Handlig with Currency >> al avialable
  var availableCurrencies =
      ['USD', 'EUR', 'GBP', 'JPY', 'AUD', 'CAD', 'CHF', 'CNY', 'EGP'].obs;
  var selectedSourceCurrency = 'USD'.obs;
  var selectedTargetCurrency = 'EGP'.obs;

  //Handlig with Date 
  var startDate = DateTime.now().subtract(const Duration(days: 30)).obs;
  var endDate = DateTime.now().obs;

   String formatDateForApi(DateTime date) {
    return DateFormat('yyyyMMdd').format(date);
  }
  /// Convert from API format (YYYY-MM-DD) to display format
  String formatDateForDisplay(String apiDateString) {
    return apiDateString;
  }

  // Handling with exchange rates >> 
  Future<void> fetchExchangeRates() async {
    isLoading.value = true;
    hasError.value = false;
    errorMessage.value = '';
    try {
      final formattedStartDate = formatDateForApi(startDate.value);
      final formattedEndDate = formatDateForApi(endDate.value);

      final result = await _exchangeService.getExchangeRates(
        startDate: formattedStartDate,
        endDate: formattedEndDate,
        sourceCurrency: selectedSourceCurrency.value,
      );

      logger.w('Log message with 2 methods');
 
 
      List<ExchangeRateRecord> records = [];

      /// Filter by target currency
      result.quotes.forEach((date, currencies) {
    
        final targetCurrencyCode =
            '${selectedSourceCurrency.value}${selectedTargetCurrency.value}';
        if (currencies.containsKey(targetCurrencyCode)) {
          records.add(ExchangeRateRecord(
            date: date,
            sourceCurrency: selectedSourceCurrency.value,
            targetCurrency: selectedTargetCurrency.value,
            rate: currencies[targetCurrencyCode]!,
          ));
        }
      });

      // Sort by date (newest first)
      records.sort((a, b) => b.date.compareTo(a.date));

      // Update data
      exchangeRateRecords.value = records;

      // Calculate total pages
      totalPages.value = (records.length / itemsPerPage).ceil();

       
      currentPage.value = 0;
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  /// Handling the pagination..
  List<ExchangeRateRecord> get currentPageRecords {
    final startIndex = currentPage.value * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;

    if (startIndex >= exchangeRateRecords.length) {
      return [];
    }

    if (endIndex > exchangeRateRecords.length) {
      return exchangeRateRecords.sublist(startIndex);
    }

    return exchangeRateRecords.sublist(startIndex, endIndex);
  }
  void nextPage() {
    if (currentPage.value < totalPages.value - 1) {
      currentPage.value++;
      }
  }
  void previousPage() {
    if (currentPage.value > 0) {
      currentPage.value--;
    }
  }
}
