import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:weather_forecast/app/app.locator.dart';
import 'package:weather_forecast/app/app.logger.dart';
import 'package:intl/intl.dart';
import 'package:weather_forecast/app/app.router.dart';
import 'package:weather_forecast/models/get_weather_daily.dart';
import 'package:weather_forecast/models/notifications_model.dart';
import 'package:weather_forecast/services/get_current_location.dart';
import 'package:weather_forecast/services/network.dart';
import 'package:weather_forecast/utils/app_strings.dart';

class WeatherPageViewmodel extends FormViewModel{
  final log = getLogger('Location Weather');

  ///REGISTERED SERVICES
  Location location = Location();
  final _navigation = locator<NavigationService>();
  final _api = locator<Network>();

  //Variables passed to the UI
  List<Daily>? datasnapshot = [];
  List<dynamic>? hoursnapshots = [];
  List<Notification>? notifications = [];
  String cityname = '';
  String city = '';
  int temperature = 0;
  String country = '';
  String? get time => formatDateTime();
  String? get date => formatDate();
  bool isCelsius = true;
  int condition = 0;

//The first method that is called when the UI is being build (Similar to Initstate in stateful widgets)
  Future<void> initialize() async {
    await getWeatherCelcius();
    await getWeatherDaily();
    await getWeather5Hours();
    await getNotificationsfor5days();
  }

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
  ///Method to get weather by the city typed in by the user in celsius
  Future getWeatherbyCityCelsius({required String name}) async {
    String url = '$baseUrl/weather?q=$name&appid=$apiKey&units=metric';
    await _api.getCityWeather(url: url).then((value) {
      condition = value!.condition!;
      cityname = value.cityName!;
      temperature = value.temp!.toInt();
      country = value.country!;
      changeCityName(value.cityName);
      log.i(value);
    });

    notifyListeners();
  }

  ///Method to get weather by the city typed in by the user in farenheit
  ///
  Future getWeatherbyCityFarenheit({required String name}) async {
    String url = '$baseUrl/weather?q=$name&appid=$apiKey&units=imperial';
    await _api.getCityWeather(url: url).then((value) {
      condition = value!.condition!;
      cityname = value.cityName!;
      temperature = value.temp!.toInt();
      country = value.country!;
      changeCityName(value.cityName);
      log.i(value);
    });

    notifyListeners();
  }

///Method to get daily weather for 5 days
///
  Future getWeatherDaily() async {
    await location.getCurrentLocation();
    String url =
        '$baseUrl/onecall?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric';
    await _api.getDailyData(url: url).then((value) {
      datasnapshot = value!.map((e) => Daily.fromJson(e)).toList();
    });
    log.i(datasnapshot);
    notifyListeners();
  }

  ///Method to get weather forecast for 5 hours
  ///
  Future getWeather5Hours() async {
    await location.getCurrentLocation();
    String url =
        '$baseUrl/onecall?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric';
    await _api.getHourData(url: url).then((value) {
      // hoursnapshots = value!.map((e) => Hourly.fromJson(e)).toList();
      hoursnapshots = value;
    });
    log.i(hoursnapshots!);
    notifyListeners();
  }

  ///Method that switches between the API call for celcius and farenheit
  ///in users's current location
  Future toggleWeather(bool val) async {
    if (val == true) {
      await getWeatherFarenheit();
    } else {
      await getWeatherCelcius();
    }
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

///Method to get weather in farenheit
///
  Future getWeatherFarenheit() async {
    await location.getCurrentLocation();
    String url =
        '$baseUrl/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=imperial';
    await _api.getCityWeather(url: url).then((value) {
      condition = value!.condition!;
      cityname = value.cityName!;
      temperature = value.temp!.toInt();
      country = value.country!;
      log.i(value);
    });

    notifyListeners();
  }

///Method to get weather in Celcius
///
  Future getWeatherCelcius() async {
    await location.getCurrentLocation();
    String url =
        '$baseUrl/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric';

    await _api.getCityWeather(url: url).then((value) {
      condition = value!.condition!;
      cityname = value.cityName!;
      temperature = value.temp!.toInt();
      country = value.country!;
      log.i(value);
    });

    notifyListeners();
  }

///Method to get weather notifications
///
  Future getNotificationsfor5days() async {
    int timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    await location.getCurrentLocation();
    for (var i = 0; i < 5; i++) {
      String url =
          '$baseUrl/onecall/timemachine?lat=${location.latitude}&lon=${location.longitude}&dt=$timestamp&appid=$apiKey&units=metric';
      await _api.getNotifications(url: url).then((value) {
        notifications!.add(value!);
      });
      log.i(notifications);
      timestamp -= 86400;
    }
  }

////NAVIGATION METHODS
///Navigate to page to get weather by city
  void navigateToCity() {
    _navigation.navigateTo(Routes.forecastReport);
  }

//Pop navigation
  void pop() {
    _navigation.back();
  }

////NOTIFICATION MESSAGES AND ICONS, CURRENT USER LOCATION ICONS
//Method to display the text that will be shown in the notifications view
  String getNotificationMessage(int currently) {
    if (currently < 300) {
      return 'There\'s thunderstorm';
    } else if (currently > 300 && currently < 400) {
      return 'It\'s drizzling in your location';
    } else if (currently > 400 && currently < 600) {
      return 'It\'s rainy in your location';
    } else if (currently >= 600 && currently < 700) {
      return 'It\'s snowy, you should get some jacket';
    } else if (currently > 700 && currently < 800) {
      return 'It\'s dusty in your location';
    } else if (currently == 800) {
      return 'It\'s sunny in your location';
    } else if (currently > 800 && currently <= 804) {
      return 'It\'s cloudy in your location';
    } else {
      return '🤷‍';
    }
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

  @override
  void setFormStatus() {
    // : implement setFormStatus
  }
}
