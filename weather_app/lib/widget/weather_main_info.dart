import 'package:flutter/material.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/utils/weather_utils.dart';

class WeatherMainInfo extends StatelessWidget {
  final WeatherModel weather;

  const WeatherMainInfo({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        Text(
          WeatherUtils.formatDate(),
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 18,
            fontWeight: FontWeight.w300,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "${weather.name}, ${weather.country}",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Icon(
          WeatherUtils.getWeatherIcon(weather.extra.icon),
          size: 140,
          color: Colors.white,
        ),
        const SizedBox(height: 30),
        Text(
          weather.extra.mainCondition.isNotEmpty 
              ? weather.extra.mainCondition
              : 'Unknown',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          weather.extra.description.isNotEmpty 
              ? '${weather.extra.description[0].toUpperCase()}${weather.extra.description.substring(1)}'
              : '',
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 18,
            fontWeight: FontWeight.w300,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          "${weather.mainWeather.temp.round()}°C",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 90,
            fontWeight: FontWeight.w200,
          ),
        ),
      ],
    );
  }
}
