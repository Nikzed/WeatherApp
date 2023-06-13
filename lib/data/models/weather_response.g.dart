// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherResponse _$WeatherResponseFromJson(Map<String, dynamic> json) =>
    WeatherResponse(
      json['cod'] as int,
      json['main'] == null
          ? null
          : WeatherTemperatureResponse.fromJson(
              json['main'] as Map<String, dynamic>),
      (json['weather'] as List<dynamic>)
          .map((e) => WeatherCloudsResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      WeatherCountryResponse.fromJson(json['sys'] as Map<String, dynamic>),
      json['name'] as String?,
      json['wind'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$WeatherResponseToJson(WeatherResponse instance) =>
    <String, dynamic>{
      'cod': instance.responseCode,
      'main': instance.temperature,
      'weather': instance.clouds,
      'sys': instance.country,
      'name': instance.city,
      'wind': instance.wind,
    };

WeatherTemperatureResponse _$WeatherTemperatureResponseFromJson(
        Map<String, dynamic> json) =>
    WeatherTemperatureResponse(
      (json['temp'] as num?)?.toDouble(),
      json['humidity'] as int?,
    );

Map<String, dynamic> _$WeatherTemperatureResponseToJson(
        WeatherTemperatureResponse instance) =>
    <String, dynamic>{
      'temp': instance.temperature,
      'humidity': instance.humidity,
    };

WeatherCloudsResponse _$WeatherCloudsResponseFromJson(
        Map<String, dynamic> json) =>
    WeatherCloudsResponse(
      json['main'] as String?,
      json['description'] as String?,
    );

Map<String, dynamic> _$WeatherCloudsResponseToJson(
        WeatherCloudsResponse instance) =>
    <String, dynamic>{
      'main': instance.clouds,
      'description': instance.description,
    };

WeatherWindResponse _$WeatherWindResponseFromJson(Map<String, dynamic> json) =>
    WeatherWindResponse(
      (json['speed'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$WeatherWindResponseToJson(
        WeatherWindResponse instance) =>
    <String, dynamic>{
      'speed': instance.speed,
    };

WeatherCountryResponse _$WeatherCountryResponseFromJson(
        Map<String, dynamic> json) =>
    WeatherCountryResponse(
      json['country'] as String?,
    );

Map<String, dynamic> _$WeatherCountryResponseToJson(
        WeatherCountryResponse instance) =>
    <String, dynamic>{
      'country': instance.country,
    };
