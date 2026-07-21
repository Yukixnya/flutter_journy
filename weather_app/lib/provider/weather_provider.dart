import 'package:flutter_riverpod/legacy.dart';
import 'package:weather_app/service/weather_service.dart';
import 'package:weather_app/service/weather_state.dart';

class WeatherNotifier extends StateNotifier<WeatherState> {
  WeatherNotifier() : super(WeatherState());

  final WeatherService _weatherServices = WeatherService();

  Future<void> getWeather(String city_name) async {
    if (city_name.trim().isEmpty) {
      state = state.copyWith(
        errorMessage: "Please enter a city name",
        weather: null,
      );
      return;
    }
    state = state.copyWith(isLoading: true, errorMessage: "", weather: null);

    try {
      final weather = await _weatherServices.getWeatherData(city_name);
      state = state.copyWith(
        isLoading: false,
        errorMessage: "",
        weather: weather,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
        weather: null,
      );
    }
  }

  Future<void> getCurrentLocationWeather(double lat, double lan) async{
    state = state.copyWith(isLoading: true, errorMessage: "", weather: null);

    try {
      final weather = await _weatherServices.getWeatherDataByLocation(lat, lan);
      state = state.copyWith(
        isLoading: false,
        errorMessage: "",
        weather: weather,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
        weather: null,
      );
    }
  }
}

final weatherProvider = StateNotifierProvider<WeatherNotifier, WeatherState>(
  (ref) => WeatherNotifier(),
);
