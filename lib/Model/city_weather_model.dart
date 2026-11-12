// To parse this JSON data, do
//
//     final cityWeatherModel = cityWeatherModelFromJson(jsonString);

import 'dart:convert';

CityWeatherModel cityWeatherModelFromJson(String str) =>
    CityWeatherModel.fromJson(json.decode(str));

String cityWeatherModelToJson(CityWeatherModel data) =>
    json.encode(data.toJson());

class CityWeatherModel {
  final CityWeather? data;

  CityWeatherModel({this.data});

  factory CityWeatherModel.fromJson(Map<String, dynamic> json) =>
      CityWeatherModel(
        data: json["data"] == null ? null : CityWeather.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {"data": data?.toJson()};
}

class CityWeather {
  final String? cityId;
  final DateTime? observedAt;
  final double? temperatureC;
  final double? feelsLikeC;
  final int? humidity;
  final double? windKph;
  final int? pressureHpa;
  final int? uvIndex;
  final WeatherCondition? condition;

  CityWeather({
    this.cityId,
    this.observedAt,
    this.temperatureC,
    this.feelsLikeC,
    this.humidity,
    this.windKph,
    this.pressureHpa,
    this.uvIndex,
    this.condition,
  });

  factory CityWeather.fromJson(Map<String, dynamic> json) => CityWeather(
    cityId: json["cityId"],
    observedAt: json["observedAt"] == null
        ? null
        : DateTime.tryParse(json["observedAt"]),
    temperatureC: json["temperatureC"]?.toDouble(),
    feelsLikeC: json["feelsLikeC"]?.toDouble(),
    humidity: json["humidity"],
    windKph: json["windKph"]?.toDouble(),
    pressureHpa: json["pressureHpa"],
    uvIndex: json["uvIndex"],
    condition: json["condition"] == null
        ? null
        : WeatherCondition.fromJson(json["condition"]),
  );

  Map<String, dynamic> toJson() => {
    "cityId": cityId,
    "observedAt": observedAt?.toIso8601String(),
    "temperatureC": temperatureC,
    "feelsLikeC": feelsLikeC,
    "humidity": humidity,
    "windKph": windKph,
    "pressureHpa": pressureHpa,
    "uvIndex": uvIndex,
    "condition": condition?.toJson(),
  };
}

class WeatherCondition {
  final String? code;
  final String? label;
  final String? icon;

  WeatherCondition({this.code, this.label, this.icon});

  factory WeatherCondition.fromJson(Map<String, dynamic> json) =>
      WeatherCondition(
        code: json["code"],
        label: json["label"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {"code": code, "label": label, "icon": icon};
}
