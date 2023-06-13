import 'package:json_annotation/json_annotation.dart';

part 'weather_response.g.dart';

@JsonSerializable()
class WeatherResponse {
  @JsonKey(name: 'cod')
  int responseCode;

  @JsonKey(name: 'main')
  WeatherTemperatureResponse? temperature;

  @JsonKey(name: 'weather')
  List<WeatherCloudsResponse> clouds;

  @JsonKey(name: 'sys')
  WeatherCountryResponse country;

  @JsonKey(name: 'name')
  final String? city;

  @JsonKey(name: 'wind')
  final Map<String, dynamic> wind;

  WeatherResponse(this.responseCode, this.temperature, this.clouds, this.country, this.city, this.wind);

  factory WeatherResponse.fromJson(Map<String, dynamic> json) => _$WeatherResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherResponseToJson(this);
}

@JsonSerializable()
class WeatherTemperatureResponse {
  @JsonKey(name: 'temp')
  final double? temperature;

  final int? humidity;

  WeatherTemperatureResponse(this.temperature, this.humidity);

  factory WeatherTemperatureResponse.fromJson(Map<String, dynamic> json) => _$WeatherTemperatureResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherTemperatureResponseToJson(this);
}

@JsonSerializable()
class WeatherCloudsResponse {
  @JsonKey(name: 'main')
  final String? clouds;

  final String? description;

  WeatherCloudsResponse(this.clouds, this.description);

  factory WeatherCloudsResponse.fromJson(Map<String, dynamic> json) => _$WeatherCloudsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherCloudsResponseToJson(this);
}

@JsonSerializable()
class WeatherWindResponse {
  final double? speed;

  WeatherWindResponse(this.speed);

  factory WeatherWindResponse.fromJson(Map<String, dynamic> json) => _$WeatherWindResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherWindResponseToJson(this);
}

@JsonSerializable()
class WeatherCountryResponse {
  final String? country;

  WeatherCountryResponse(this.country);

  factory WeatherCountryResponse.fromJson(Map<String, dynamic> json) => _$WeatherCountryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherCountryResponseToJson(this);
}
