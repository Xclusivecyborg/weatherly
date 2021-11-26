class Daily {
  Daily({
    this.condition,
    this.dt,
    this.temp,
   
  });
  int? dt;
  double? temp;
  
  int? condition;

  factory Daily.fromJson(Map<String, dynamic> json) => Daily(
      dt: json['dt'],
      temp: json["temp"]["day"],
      
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
