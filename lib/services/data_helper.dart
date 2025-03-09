
import 'package:intl/intl.dart';

class DateHelper {
// in this class i trying to make history in the same Format :: YYYY-MM-DD

   static String formatDateForApi(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }
  
 /// Make The Date YYYY-MM-DD if Not
  static String formatStringDateForApi(String date) {
     if (date.length == 8 && !date.contains('-')) {
      return '${date.substring(0, 4)}-${date.substring(4, 6)}-${date.substring(6, 8)}';
    }
    return date;
  }
  
 
 /// Convert from API format (YYYY-MM-DD) to display format
  static String formatDateForDisplay(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }
  
  // Parse date  
  static DateTime parseDate(String dateStr) {
     try {
      // First try YYYY-MM-DD
      if (dateStr.contains('-')) {
        return DateFormat('yyyy-MM-dd').parse(dateStr);
      }
      
      // Then try YYYYMMDD
      if (dateStr.length == 8) {
        return DateFormat('yyyyMMdd').parse(dateStr);
      }
      
      // the Default 
      return DateTime.parse(dateStr);
    } catch (e) {
       return DateTime.now();
    }
  }
}