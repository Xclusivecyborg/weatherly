import 'package:dio/dio.dart';
import 'package:weather_forecast/app/app.logger.dart';
import 'package:weather_forecast/models/get_location_model.dart';
import 'package:weather_forecast/models/get_weather_daily.dart';
import 'package:weather_forecast/models/get_weather_hourly.dart';
import 'package:weather_forecast/models/notifications_model.dart';
import 'package:weather_forecast/widgets/custom_toast.dart';

class Network {
  final log = getLogger('Network requests');
  final Dio? dio;

  Network({required this.dio});

  Future<LocationWeather?> getCityWeather({required String url}) async {
    log.i('Making request to $url ');
    try {
      var response = await dio!.get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        return LocationWeather.fromJson(data);
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.other) {
        customtoast(toastmessage: 'Please check your internet connection');
      } else {
        customtoast(toastmessage: e.response!.data["message"]);
        log.e(e.response!.data["message"]);
      }
    }
  }

  Future<List<Hourly>?> getHourData({required String url}) async {
    log.i('Making request to $url ');
    try {
      var response = await dio!.get(url);
      if (response.statusCode == 200) {
        List data = response.data["hourly"];
        return data.map((e) => Hourly.fromJson(e)).toList();
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.other) {
        customtoast(toastmessage: 'Please check your internet connection');
      } else {
        customtoast(toastmessage: e.response!.data["message"]);
        log.e(e.message);
      }
    }
  }

  Future<List<Daily>?> getDailyData({required String url}) async {
    log.i('Making request to $url ');
    try {
      var response = await dio!.get(url);
      if (response.statusCode == 200) {
        final List data = response.data["daily"];
        return data.map((e) => Daily.fromJson(e)).toList();
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.other) {
        customtoast(toastmessage: 'Please check your internet connection');
      } else {
        customtoast(toastmessage: e.response!.data["message"]);
        log.e(e.message);
      }
    }
  }

  Future<Notification?> getNotifications({required String url}) async {
    log.i('Making request to $url ');
    try {
      var response = await dio!.get(url);
      if (response.statusCode == 200) {
        final data = response.data["current"];
        return Notification.fromJson(data);
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.other) {
        customtoast(toastmessage: 'Please check your internet connection');
      } else {
        customtoast(toastmessage: e.response!.data["message"]);
        log.e(e.message);
      }
    }
  }
}
