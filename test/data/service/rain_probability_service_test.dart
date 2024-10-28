import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'dart:convert';

import 'package:tennis_booking/src/data/services/interfaces/rain_probability_service.dart';
import 'package:tennis_booking/src/data/services/rain_probability_service.dart';



void main() {
  group('RainProbabilityService', () {
    late RainProbabilityServiceI service;

    setUp(() {
      service = RainProbabilityService(
        client: MockClient((request) async {
          final mockResponse = {
            "hourly": {
              "time": [
                "2024-10-30T00:00",
                "2024-10-30T14:00",
                "2024-10-30T23:00",
              ],
              "precipitation_probability": [58, 70, 85],
            },
          };
          return http.Response(json.encode(mockResponse), 200);
        }),
      );
    });

    test('returns correct rain probability for specific date and time', () async {
      final probability = await service.getRainProbability("30/10/2024", "14:00");
      expect(probability, 70);
    });

    test('returns null when there is no data for specified time', () async {
      final probability = await service.getRainProbability("30/10/2024", "15:00");
      expect(probability, isNull);
    });

    test('throws FormatException for invalid date format', () async {
      expect(() async => await service.getRainProbability("30-10-2024", "14:00"),
          throwsA(isA<FormatException>()));
    });

    test('returns null on HTTP error', () async {
      service = RainProbabilityService(
        client: MockClient((request) async {
          return http.Response('Not Found', 404);
        }),
      );
      final probability = await service.getRainProbability("30/10/2024", "14:00");
      expect(probability, isNull);
    });

    test('returns null on exception', () async {
      service = RainProbabilityService(
        client: MockClient((request) async {
          throw Exception('Network error');
        }),
      );
      final probability = await service.getRainProbability("30/10/2024", "14:00");
      expect(probability, isNull);
    });
  });
}
