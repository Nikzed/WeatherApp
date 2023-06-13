class WeatherModel {
  int temperature;
  int humidity;
  String clouds;
  String cloudsDescription;
  double windSpeed;
  String? country;
  String? city;

  WeatherModel({
    required this.temperature,
    required this.humidity,
    required this.clouds,
    required this.cloudsDescription,
    required this.windSpeed,
    required this.country,
    required this.city,
  });
}
