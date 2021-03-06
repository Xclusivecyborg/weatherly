import 'package:equatable/equatable.dart';

class LocationWeather extends Equatable {
  final String? temp;
  final String? cityName;
  final String? country;
  final int? condition;

  @override
  List<Object?> get props => [
        temp,
        cityName,
        country,
        condition,
      ];

  const LocationWeather(
      {this.condition, this.country, this.temp, this.cityName});

  factory LocationWeather.fromJson(Map<String, dynamic> json) {
    return LocationWeather(
      cityName: json['name'],
      temp: json['main']['temp'].toString(),
      country: json['sys']['country'],
      condition: json['weather'][0]['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "cityName": cityName,
      "temp": temp,
      "country": country,
      "condition": condition,
    };
  }

  @override
  String toString() {
    return 'temp : $temp, cityName: $cityName, country : $country, condition : $condition';
  }
}
