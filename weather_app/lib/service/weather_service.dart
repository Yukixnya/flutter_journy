import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  final String appid = dotenv.env['OPEN_WEATHER_API_KEY']!;
  final String baseUrl = "https://api.openweathermap.org/data/2.5";

  Future<WeatherModel?> getWeatherData(String city_name) async {
    try {
      String url = "$baseUrl/weather?q=$city_name&appid=$appid&units=metric";
      http.Response res = await http.get(Uri.parse(url));

      if(res.statusCode == 200){
        final Map<String, dynamic> jsonData = jsonDecode(res.body) as Map<String, dynamic>;

        return WeatherModel.fromJson(jsonData);
      }
      else{
        throw Exception("Failed to get weather");
      }
    }
    catch (e){
      throw Exception("Error: $e");
    }
  }

  Future<WeatherModel?> getWeatherDataByLocation(double lat, double lon) async {
    try {
      String url = "$baseUrl/weather?lat=$lat&lon=$lon&appid=$appid&units=metric";
      http.Response res = await http.get(Uri.parse(url));

      if(res.statusCode == 200){
        final Map<String, dynamic> jsonData = jsonDecode(res.body) as Map<String, dynamic>;
        return WeatherModel.fromJson(jsonData);
      }
      else{
        throw Exception("Failed to get weather by location");
      }
    }
    catch (e){
      throw Exception("Error: $e");
    }
  }
}