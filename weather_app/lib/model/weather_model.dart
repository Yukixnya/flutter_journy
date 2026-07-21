import 'package:weather_app/model/weather_cord_model.dart';
import 'package:weather_app/model/weather_extra_model.dart';
import 'package:weather_app/model/weather_main_model.dart';
import 'package:weather_app/model/weather_wind_model.dart';

class WeatherModel {
  final WeatherCord cord;
  final String name;
  final String country;
  final WeatherMain mainWeather;
  final WeatherWind wind;
  final WeatherExtraModel extra;
  final int sunrise;
  final int sunset;

  WeatherModel({
    required this.cord,
    required this.name,
    required this.country,
    required this.mainWeather,
    required this.wind,
    required this.extra,
    required this.sunrise,
    required this.sunset,
  });

  WeatherModel.fromJson(Map<String, dynamic> json)
    : cord = WeatherCord.fromJson(json['coord'] ?? {}),
      name = json['name'] ?? '',
      country = json['sys']?['country'] ?? '',
      sunrise = json['sys']?['sunrise'] ?? 0,
      sunset = json['sys']?['sunset'] ?? 0,
      mainWeather = WeatherMain.fromJson(json['main'] ?? {}),
      wind = WeatherWind.fromJson(json['wind'] ?? {}),
      extra = WeatherExtraModel.fromJson(json);
}
