import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_forecast/models/get_location_model.dart';
import 'package:weather_forecast/models/get_weather_daily.dart';
import 'package:weather_forecast/models/get_weather_hourly.dart';
import 'package:weather_forecast/models/notifications_model.dart';
import 'package:weather_forecast/services/network.dart';
import 'package:weather_forecast/utils/app_strings.dart';

import '../fixture/location_fixture.dart';
import '../fixture/notification_fixture.dart';

class MockDio extends Mock implements Dio {}

void main() async {
  final dio = MockDio();
  final network = Network(dio: dio);

  group('Network Calls - ', () {
    test(
        'When function is called, a locationweather object is returned from the API',
        () async {
      String name = 'Lagos';
      String url = '$baseUrl/weather?q=$name&appid=$apiKey&units=metric';

      when(() => dio.get(any())).thenAnswer(
        (_) => Future.value(
          Response(
            data: locationFixture,
            statusCode: 200,
            requestOptions: RequestOptions(path: ''),
          ),
        ),
      );
      final networkcall = await network.getCityWeather(url: url);
      expect(networkcall, equals(isA<LocationWeather>()));
    });
    test(
        'When function is called, a Notification object is returned from the API',
        () async {
      int timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      String url =
          '$baseUrl/onecall/timemachine?lat=${48.6}&lon=${50.5}&dt=$timestamp&appid=$apiKey&units=metric';

      when(() => dio.get(any())).thenAnswer(
        (_) => Future.value(
          Response(
            data: notificationFixture,
            statusCode: 200,
            requestOptions: RequestOptions(path: ''),
          ),
        ),
      );
      final networkcall = await network.getNotifications(url: url);
      expect(networkcall, equals(isA<Notification>()));
    });

    test('When function is called, List of type Daily is returned from the API',
        () async {
      String url =
          '$baseUrl/onecall?lat=${38.90}&lon=${44.70}&appid=$apiKey&units=metric';
      when(() => dio.get(any())).thenAnswer(
        (_) => Future.value(
          Response(
            data: {'daily': []},
            statusCode: 200,
            requestOptions: RequestOptions(path: ''),
          ),
        ),
      );
      final networkcall = await network.getDailyData(url: url);
      expect(networkcall!, <Daily>[]);
    });

    test(
        'When function is called, List of type Hourly is returned from the API',
        () async {
      String url =
          '$baseUrl/onecall?lat=${38.90}&lon=${44.70}&appid=$apiKey&units=metric';
      when(() => dio.get(any())).thenAnswer(
        (_) => Future.value(
          Response(
            data: {'hourly': []},
            statusCode: 200,
            requestOptions: RequestOptions(path: ''),
          ),
        ),
      );
      final networkcall = await network.getHourData(url: url);
      expect(networkcall!, <Hourly>[]);
    });
  });
}
