import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeatherUtils {
  static String formatDate() {
    return DateFormat('EEEE, MMMM d').format(DateTime.now());
  }

  static String formatTime(int timestamp) {
    if (timestamp == 0) return "--:--";
    final dt = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat('HH:mm').format(dt);
  }

  static String getCompassDirection(int deg) {
    const directions = ['N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW'];
    return directions[((deg % 360) / 45).round() % 8];
  }

  static IconData getWeatherIcon(String iconCode) {
    switch (iconCode) {
      case '01d': return Icons.wb_sunny;
      case '01n': return Icons.nightlight_round;
      case '02d':
      case '02n': return Icons.cloud_queue;
      case '03d':
      case '03n':
      case '04d':
      case '04n': return Icons.cloud;
      case '09d':
      case '09n':
      case '10d':
      case '10n': return Icons.water_drop; 
      case '11d':
      case '11n': return Icons.flash_on; 
      case '13d':
      case '13n': return Icons.ac_unit; 
      case '50d':
      case '50n': return Icons.filter_drama; 
      default: return Icons.wb_cloudy;
    }
  }
}
