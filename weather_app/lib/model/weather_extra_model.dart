class WeatherExtraModel {
  final int all_cloud;
  final int visibility;
  final String description;
  final String mainCondition;
  final String icon;

  WeatherExtraModel({
    required this.all_cloud,
    required this.visibility,
    required this.description,
    required this.mainCondition,
    required this.icon,
  });

  WeatherExtraModel.fromJson(Map<String, dynamic> json)
    : all_cloud = json['clouds']?['all'] ?? 0,
      visibility = json['visibility'] ?? 0,
      description = (json['weather'] != null && json['weather'].isNotEmpty) ? json['weather'][0]['description'] ?? '' : '',
      mainCondition = (json['weather'] != null && json['weather'].isNotEmpty) ? json['weather'][0]['main'] ?? '' : '',
      icon = (json['weather'] != null && json['weather'].isNotEmpty) ? json['weather'][0]['icon'] ?? '' : '';
}
