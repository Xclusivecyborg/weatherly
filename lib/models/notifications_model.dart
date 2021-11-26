class Notification {
  Notification({
    this.dt,
    this.weather,
  });

  int? dt;

  List<Weather>? weather;

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        dt: json["dt"],
        weather:
            List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "dt": dt,
        "weather": List<dynamic>.from(weather!.map((x) => x.toJson())),
      };
  @override
  String toString() {
    return 'dt : $dt, weather : $weather';
  }
}

class Weather {
  Weather({
    this.id,
  });

  int? id;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };

  @override
  String toString() {
    return 'id : $id';
  }
}

enum Description { overcastClouds, lightSnow }

final descriptionValues = EnumValues({
  "light snow": Description.lightSnow,
  "overcast clouds": Description.overcastClouds
});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map!.map((k, v) => MapEntry(v, k));
    return reverseMap!;
  }
}
