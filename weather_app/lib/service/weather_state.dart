import 'package:weather_app/model/weather_model.dart';

class WeatherState {
  final bool isLoading;
  final String errorMessage;
  final WeatherModel? weather;

  WeatherState({
    this.isLoading = false,
    this.errorMessage = '',
    this.weather,
  });

  WeatherState copyWith({
    bool? isLoading,
    String? errorMessage,
    WeatherModel? weather,
  }) {
    return WeatherState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      weather: weather,
    );
  }
}
