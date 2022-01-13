import 'package:dio/dio.dart';
import 'package:weather_forecast/app/app.logger.dart';
import 'package:weather_forecast/models/get_location_model.dart';
import 'package:weather_forecast/models/get_weather_daily.dart';
import 'package:weather_forecast/models/notifications_model.dart';
import 'package:weather_forecast/widgets/custom_toast.dart';

class Network {
  final log = getLogger('Network requests');

  static Network? _instance;
  static Dio? _dio;

  static Future<Network> getInstance() async {
    _instance ??= Network();
    _dio ??= Dio();
    return _instance!;
  }

  Future<LocationWeather?> getCityWeather({required String url}) async {
    try {
      var response = await _dio!.get(url);
      if (response.statusCode == 200) {
        return LocationWeather.fromJson(response.data);
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.other) {
        customtoast(toastmessage: 'You\'re not connected to the internet');
      } else {
        customtoast(toastmessage: e.response!.data["message"]);
        log.e(e.response!.data["message"]);
      }
    }
  }

  Future<List<dynamic>?> getHourData({required String url}) async {
    try {
      var response = await _dio!.get(url);
      if (response.statusCode == 200) {
        return response.data["hourly"];
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.other) {
        customtoast(toastmessage: 'You\'re not connected to the internet');
      } else {
        customtoast(toastmessage: e.response!.data["message"]);
        log.e(e.message);
      }
    }
  }

  Future<List<Daily>?> getDailyData({required String url}) async {
    try {
      var response = await _dio!.get(url);
      if (response.statusCode == 200) {
        final List data = response.data["daily"];
        return data.map((e) => Daily.fromJson(e)).toList();
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.other) {
        customtoast(toastmessage: 'You\'re not connected to the internet');
      } else {
        customtoast(toastmessage: e.response!.data["message"]);
        log.e(e.message);
      }
    }
  }

  Future<Notification?> getNotifications({required String url}) async {
    try {
      var response = await _dio!.get(url);
      if (response.statusCode == 200) {
        final data = response.data["current"];
        return Notification.fromJson(data);
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.other) {
        customtoast(toastmessage: 'You\'re not connected to the internet');
      } else {
        customtoast(toastmessage: e.response!.data["message"]);
        log.e(e.message);
      }
    }
  }
}
