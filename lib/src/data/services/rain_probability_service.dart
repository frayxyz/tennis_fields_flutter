
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'interfaces/rain_probability_service.dart';


class RainProbabilityService implements RainProbabilityServiceI {
  final String baseUrl = "https://api.open-meteo.com/v1/forecast";
  final String latitude = "6.2139";
  final String longitude = "-75.5723";
  final http.Client httpClient;

  RainProbabilityService({http.Client? client}) : httpClient = client ?? http.Client();

  @override
  Future<int?> getRainProbability(String date, String time) async {
    final parsedDate = DateTime.parse(date.split("/").reversed.join("-"));
    final url = Uri.parse(
      "$baseUrl?latitude=$latitude&longitude=$longitude&hourly=precipitation_probability&start_date=${parsedDate.toIso8601String().substring(0, 10)}&end_date=${parsedDate.toIso8601String().substring(0, 10)}&timezone=America/Bogota",
    );

    try {
      final response = await httpClient.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final formattedTime = "${parsedDate.toIso8601String().substring(0, 10)}T$time";

        List<dynamic> times = data['hourly']['time'];
        List<dynamic> precipitationProbabilities = data['hourly']['precipitation_probability'];

        for (int i = 0; i < times.length; i++) {
          if (times[i] == formattedTime) {
            return precipitationProbabilities[i];
          }
        }
      } else {
        throw Exception('Error en la consulta: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint("Error: $e");
      return null;
    }
    return null;
  }
}
