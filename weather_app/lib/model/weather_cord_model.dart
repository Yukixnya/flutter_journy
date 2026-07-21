class WeatherCord {
  final double lat;
  final double lon;

  WeatherCord({required this.lat, required this.lon});

  WeatherCord.fromJson(Map<String, dynamic> json)
    : lat = (json['lat'] ?? 0.0).toDouble(),
      lon = (json['lon'] ?? 0.0).toDouble();
}
