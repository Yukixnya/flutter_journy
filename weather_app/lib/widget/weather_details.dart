import 'package:flutter/material.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/utils/weather_utils.dart';

class WeatherDetails extends StatelessWidget {
  final WeatherModel weather;

  const WeatherDetails({super.key, required this.weather});

  Widget _buildDetailCard(String label, String value, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.15)),
      ),
      padding: const EdgeInsets.all(8),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Dynamically scale icon and font sizes based on the box height/width constraints
          final double iconSize = constraints.maxHeight * 0.28;
          final double labelSize = constraints.maxHeight * 0.12;
          final double valueSize = constraints.maxHeight * 0.16;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white70, size: iconSize),
              SizedBox(height: constraints.maxHeight * 0.05),
              Text(
                label,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: labelSize,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: constraints.maxHeight * 0.05),
              // Use FittedBox to guarantee the value scales down if it's too long (e.g. pressure)
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  value,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: valueSize,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          const SizedBox(height: 20),
          GridView.extent(
            maxCrossAxisExtent: 200, // Dynamically calculates how many columns can fit (e.g. 2 on phones, 4 on tablets, 6 on desktop)
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 1.1, // slightly wider than a perfect square to fit text
            children: [
              // Temperature & Clouds
              _buildDetailCard("Feels Like", "${weather.mainWeather.feels_like.round()}°", Icons.thermostat),
              _buildDetailCard("Cloud Cover", "${weather.extra.all_cloud}%", Icons.cloud),
              // Moisture & Air
              _buildDetailCard("Humidity", "${weather.mainWeather.humidity}%", Icons.water_drop),
              _buildDetailCard("Visibility", "${(weather.extra.visibility / 1000).toStringAsFixed(1)} km", Icons.visibility),
              // Wind Stats
              _buildDetailCard("Wind", "${weather.wind.speed} m/s", Icons.air),
              _buildDetailCard("Wind Gust", "${weather.wind.gust} m/s", Icons.wind_power),
              _buildDetailCard("Wind Dir", WeatherUtils.getCompassDirection(weather.wind.deg), Icons.explore),
              _buildDetailCard("Pressure", "${weather.mainWeather.pressure} hPa", Icons.speed),
              // Solar
              _buildDetailCard("Sunrise", WeatherUtils.formatTime(weather.sunrise), Icons.wb_twilight),
              _buildDetailCard("Sunset", WeatherUtils.formatTime(weather.sunset), Icons.nights_stay),
            ],
          ),
        ],
      ),
    );
  }
}
