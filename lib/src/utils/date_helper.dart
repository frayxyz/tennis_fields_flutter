import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class DateHelper {
  static String formatDateToString(DateTime date) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(date);
  }

  static DateTime? parseStringToDate(String dateString) {
    try {
      final DateFormat formatter = DateFormat('dd/MM/yyyy');
      return formatter.parse(dateString);
    } catch (e) {
      print("Error parsing date string: $e");
      return null;
    }
  }

  static List<String> generateHourlyIntervals(
      String openingTime, String closingTime) {
    debugPrint("openingtime  $openingTime and closingTime $closingTime");
    // Parsear openingTime y closingTime a DateTime
    final startTime = DateTime.parse('1970-01-01 $openingTime:00');
    final endTime = DateTime.parse('1970-01-01 $closingTime:00');

    List<String> hourlyIntervals = [];
    DateTime current = startTime;

    // Generar los intervalos de una hora
    while (current.isBefore(endTime) || current.isAtSameMomentAs(endTime)) {
      hourlyIntervals.add(
          "${current.hour.toString().padLeft(2, '0')}:${current.minute.toString().padLeft(2, '0')}");
      current = current.add(const Duration(hours: 1)); // Incrementar una hora
    }
    debugPrint("hourlyIntervals ${hourlyIntervals.length}");
    return hourlyIntervals;
  }

  static int getDifferenceBetweenHours(String startTime, String endTime) {
    DateTime startDateTime = DateTime.parse("2000-01-01 $startTime:00");
    DateTime endDateTime = DateTime.parse("2000-01-01 $endTime:00");

    return endDateTime.difference(startDateTime).inHours;
  }

  static String formatDateLanguage(String date, {String languageCode = 'es'}) {
    try {
      initializeDateFormatting(languageCode);
      final locale = Locale(languageCode);
      final formatter =
          DateFormat.yMMMMd('${locale.languageCode}-${locale.countryCode}');
      return formatter.format(parseStringToDate(date)!);
    } catch (e) {
      print("Error al formatear la fecha: $e");
      return date; // Return original if formatting fails
    }
  }
}
