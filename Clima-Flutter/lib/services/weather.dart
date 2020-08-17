import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const apikey = '0a5f5cc44be2e82a07afa4f306e9833a';
const weatherMapUrl = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityweather(String city) async {
    var url = '$weatherMapUrl?q=$city&appid=$apikey&units=metric';
    NewtorkHelper weatherGetter = NewtorkHelper(url);
    var weatherData = await weatherGetter.getData();
    return weatherData;
  }

  Future getWeatherData() async {
    Location location = Location();
    await location.getCurrentLocation();

    String url =
        '$weatherMapUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$apikey&units=metric';
    NewtorkHelper weatherGetter = NewtorkHelper(url);
    var weatherData = await weatherGetter.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
