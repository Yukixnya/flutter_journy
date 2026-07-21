class WeatherWind {
  final double speed;
  final int deg;
  final double gust;

  WeatherWind({required this.speed, required this.deg, required this.gust});

  WeatherWind.fromJson(Map<String, dynamic> json)
    : speed = (json['speed'] ?? 0.0).toDouble(),
      deg = json['deg'] ?? 0,
      gust = (json['gust'] ?? 0.0).toDouble();
}
