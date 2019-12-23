import 'package:flutter/material.dart';

const dataid = 'F-C0032-001';
const apiKey = 'CWB-9986681F-B9E6-474D-8458-753CD3B1C344';
const format = 'JSON';

// class WeatherModel {
//   Future<dynamic> getCityWeather(String cityName) async {
//     NetworkHelper networkHelper = NetworkHelper(
//         '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric');

//     var weatherData = await networkHelper.getData();
//     return weatherData;
//   }

// Future<dynamic> getLocationWeather() async {
//   Location location = Location();
//   await location.getCurrentLocation();

//   NetworkHelper networkHelper = NetworkHelper(
//       '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

//   var weatherData = await networkHelper.getData();

//   return weatherData;
// }

String getWeatherIcon(int parameterValue) {
  if (parameterValue == 1) {
    return '☀️';
  } else if (parameterValue <= 3) {
    return '🌥️';
  } else if (parameterValue <= 7) {
    return '☁️';
  } else if (parameterValue <= 22) {
    return '🌧️';
  } else {
    return '🤷‍';
  }
}

// }
