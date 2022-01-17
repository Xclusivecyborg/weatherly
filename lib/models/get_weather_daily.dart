import 'package:equatable/equatable.dart';

class Daily extends Equatable {
  const Daily({
    this.condition,
    this.dt,
    this.temp,
  });
  final int? dt;
  final String? temp;

  final int? condition;

  @override

  List<Object?> get props => [
    temp, dt, condition 
  ];

  factory Daily.fromJson(Map<String, dynamic> json) => Daily(
        dt: json['dt'],
        temp: json["temp"]["day"].toString(),
        condition: json["weather"][0]["id"],
      );

  Map<String, dynamic> toJson() => {
        "temp": temp,
        "dt": dt,
        "condition": condition,
      };

  @override
  String toString() {
    return 'temp: $temp, dt: $dt , conditon: $condition';
  }
}
