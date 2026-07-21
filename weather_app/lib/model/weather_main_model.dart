class WeatherMain {
  final double temp;
  final double feels_like;
  final int pressure;
  final int humidity;

  WeatherMain({
    required this.temp,
    required this.feels_like,
    required this.pressure,
    required this.humidity,
  });

  WeatherMain.fromJson(Map<String, dynamic> json)
    : temp = (json['temp'] ?? 0.0).toDouble(),
      feels_like = (json['feels_like'] ?? 0.0).toDouble(),
      pressure = json['pressure'] ?? 0,
      humidity = json['humidity'] ?? 0;
}
