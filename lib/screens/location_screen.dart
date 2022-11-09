import 'package:flutter/material.dart';
import 'package:zweather/screens/city_screens.dart';
import 'package:zweather/services/weather.dart';
import 'package:zweather/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key, this.locationWeather}) : super(key: key);

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int temperature = 0;
  String weatherIcon = '';
  String weatherMessage = '';

  String city = '';

  @override
  void initState() {
    super.initState();

    updateUI(widget.locationWeather);
  }

  void updateUI(weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        weatherMessage = 'Unable to get weather data';
        city = '';
        return;
      }
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      var condition = weatherData['weather'][0]['id'];
      city = weatherData['name'];
      weatherIcon = weather.getWeatherIcon(condition);
      weatherMessage = weather.getMessage(temperature);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/clear.jpeg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.8),
              BlendMode.dstATop,
            ),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () async {
                      var weatherData = await weather.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      var typedName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const CityScreen();
                          },
                        ),
                      );
                      if (typedName != '') {
                        var cityWeatherData =
                            await weather.getCityWeather(typedName);
                        updateUI(cityWeatherData);
                        // print(cityWeatherData);
                      }
                      var cityWeatherData = weather.getCityWeather(typedName);
                      updateUI(cityWeatherData);
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 15.0,
                ),
                child: Row(
                  children: [
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 15.0,
                ),
                child: Row(
                  children: [
                    Text(
                      '$weatherMessage  in $city !',
                      textAlign: TextAlign.justify,
                      style: kMessageTextStyle,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
