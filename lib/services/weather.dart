import 'package:zweather/services/location.dart';
import 'package:zweather/services/networking.dart';
import 'package:zweather/utilities/constants.dart';

const kOpenWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String typedName) async {
    final url = '$kOpenWeatherMapURL?q=$typedName&appid=$kApiKey&units=metric';

    NetworkHelper networkHelper = NetworkHelper(url);

    var cityWeatherData = await networkHelper.getData();
    return cityWeatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    final url =
        '$kOpenWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$kApiKey&units=metric';

    NetworkHelper networkHelper = NetworkHelper(url);

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '🌦 ';
    } else if (condition < 700) {
      return '❄️';
    } else if (condition < 800) {
      return 'Fog';
    } else if (condition == 800) {
      return '🟠';
    } else if (condition <= 804) {
      return '☁️';
    }
    return 'I don\'t know what weather is up to today';
  }

  String getMessage(int temperature) {
    if (temperature > 25) {
      return 'It\' 🍦 time';
    } else if (temperature > 20) {
      return 'It\'s time for some shorts & shirt';
    } else if (temperature < 10) {
      return 'You\'ll need jacket & some gloves';
    }
    return 'Bring a 🧥 just incase';
  }
}
