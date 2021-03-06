class Hourly {
  Hourly({
    this.temp,
    this.dt,
    this.condition
  });

  String? temp;
  int? dt;
  int? condition;
  factory Hourly.fromJson(Map<String, dynamic> json) => Hourly(
        dt: json["dt"],
        temp: json["temp"].toString(),
       condition: json["weather"][0]["id"],
      );

  Map<String, dynamic> toJson() => {
        "temp": temp,
        "dt": dt,
      };
}
