

import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:weather_forecast/app/app.logger.dart';
import 'package:weather_forecast/services/get_current_location.dart';
import 'package:weather_forecast/services/network.dart';
import 'package:weather_forecast/utils/app_strings.dart';

class LocationViewModel extends BaseViewModel {
  LocationViewModel(
      {required this.location, required this.navigation, required this.api});

        final log = getLogger('Location Viewmodel');

  ///REGISTERED SERVICES
  final Location location;
  final NavigationService navigation;
  final Network api;


//Variables passed to the UI
 
  String cityname = '';
  String city = '';
  String temperature = '';
  String country = '';


  String? get time => formatDateTime();
  String? get date => formatDate();
  bool isCelsius = true;
  int condition = 0;


//Method to change city name based on the city typed in by the user.
  void changeCityName(val) {
    city = val;
    notifyListeners();
  }


  ///This method changes the value to either celcius or farenheit
  void toggleCelsius() {
    isCelsius = !isCelsius;
    notifyListeners();
  }

///Methods to format date and time into readable formats
  String formatDateTime() {
    var time = DateFormat.jm().format(DateTime.now());
    return '$time ';
  }

  String formatDate() {
    var time = DateFormat('EEE, d MMM').format(DateTime.now());
    return '$time ';
  }

  ///METHODS THAT GETS WEATHER DATA FROM THE API
  /// =======> Method to get weather for the city typed in by the user in celsius <=======
  Future getWeatherbyCityCelsius({required String name}) async {
    String url = '$baseUrl/weather?q=$name&appid=$apiKey&units=metric';
    await api.getCityWeather(url: url).then((value) {
      condition = value!.condition!;
      cityname = value.cityName!;
      temperature = value.temp!;
      country = value.country!;
      changeCityName(value.cityName);
      log.i(value);
    });

    notifyListeners();
  }

  ///=======> Method to get weather for the city typed in by the user in farenheit <=======
  ///
  Future getWeatherbyCityFarenheit({required String name}) async {
    String url = '$baseUrl/weather?q=$name&appid=$apiKey&units=imperial';
    await api.getCityWeather(url: url).then((value) {
      condition = value!.condition!;
      cityname = value.cityName!;
      temperature = value.temp!;
      country = value.country!;
      changeCityName(value.cityName);
      log.i(value);
    });

    notifyListeners();
  }
   ///Method to get weather in farenheit
  ///
  Future getWeatherFarenheit() async {
    await location.getCurrentLocation();
    String url =
        '$baseUrl/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=imperial';
    await api.getCityWeather(url: url).then((value) {
      condition = value!.condition!;
      cityname = value.cityName!;
      temperature = value.temp!;
      country = value.country!;
      log.i(value);
    });

    notifyListeners();
  }


///Method that switches between the API call for celcius and farenheit
  ///for the city typed in by user
  Future toggleLocation(bool val, String loc) async {
    if (val == true) {
      await getWeatherbyCityFarenheit(name: loc);
    } else {
      await getWeatherbyCityCelsius(name: loc);
    }
    notifyListeners();
  }

  ///Method to get the icon that will be shown in both the notification view
  ///and the current user location view
  String getWeatherIcon(int cond) {
    if (cond < 300) {
      return '🌩';
    } else if (cond > 300 && cond < 400) {
      return '🌧';
    } else if (cond > 400 && cond < 600) {
      return '🌧️';
    } else if (cond >= 600 && cond < 700) {
      return '☃️';
    } else if (cond > 700 && cond < 800) {
      return '🌫';
    } else if (cond == 800) {
      return '☀️';
    } else if (cond > 800 && cond <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  //Pop navigation
  void pop() {
    navigation.back();
  }

}