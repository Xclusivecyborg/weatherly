class Daily {
  Daily({
    this.condition,
    this.dt,
    required this.temp,
   
  });
  int? dt;
  String temp;
  
  int? condition;

  factory Daily.fromJson(Map<String, dynamic> json) => Daily(
      dt: json['dt'],
      temp: json["temp"]["day"].toString(),
      
      condition: json["weather"][0]["id"],);

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
