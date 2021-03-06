import 'package:geolocator/geolocator.dart';

class Location {
  static Location? location;

  double? longitude;
  double? latitude;
  Location({this.longitude, this.latitude});


  Future getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      latitude = position.latitude;

      longitude = position.longitude;
    } catch (e) {
      throw e.toString();
    }
  }
}
