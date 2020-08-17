import 'package:geolocator/geolocator.dart';

class Location {
  double longitude;
  double latitude;
  Future<void> getCurrentLocation() async {
    try {
      Position myCurrentPosition = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      longitude = myCurrentPosition.longitude;
      latitude = myCurrentPosition.latitude;
    } catch (e) {
      print('error occurs');
      print(e);
    }
  }
}
