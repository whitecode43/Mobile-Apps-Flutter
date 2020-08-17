import 'package:flutter/material.dart';

import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima/services/weather.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void getMyLocation() async {
    var weatherData = await WeatherModel().getWeatherData();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(weatherData);
    }));
  }

  @override
  void initState() {
    super.initState();
    getMyLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: SpinKitCircle(
      color: Colors.white,
      size: 100.0,
    )));
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    print('ByeBye');
  }
}
