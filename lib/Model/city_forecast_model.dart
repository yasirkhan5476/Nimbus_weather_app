// To parse this JSON data, do
//
//     final cityForecastModel = cityForecastModelFromJson(jsonString);

import 'dart:convert';

CityForecastModel cityForecastModelFromJson(String str) =>
    CityForecastModel.fromJson(json.decode(str));

String cityForecastModelToJson(CityForecastModel data) =>
    json.encode(data.toJson());

class CityForecastModel {
  final List<ForecastDay>? data;

  CityForecastModel({this.data});

  factory CityForecastModel.fromJson(Map<String, dynamic> json) =>
      CityForecastModel(
        data: json["data"] == null
            ? []
            : List<ForecastDay>.from(
                json["data"]!.map((x) => ForecastDay.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ForecastDay {
  final DateTime? date;
  final String? weekday;
  final double? highC;
  final double? lowC;
  final int? rainChance;
  final ForecastCondition? condition;

  ForecastDay({
    this.date,
    this.weekday,
    this.highC,
    this.lowC,
    this.rainChance,
    this.condition,
  });

  factory ForecastDay.fromJson(Map<String, dynamic> json) => ForecastDay(
    date: json["date"] == null ? null : DateTime.tryParse(json["date"]),
    weekday: json["weekday"],
    highC: json["highC"]?.toDouble(),
    lowC: json["lowC"]?.toDouble(),
    rainChance: json["rainChance"],
    condition: json["condition"] == null
        ? null
        : ForecastCondition.fromJson(json["condition"]),
  );

  Map<String, dynamic> toJson() => {
    "date": date?.toIso8601String(),
    "weekday": weekday,
    "highC": highC,
    "lowC": lowC,
    "rainChance": rainChance,
    "condition": condition?.toJson(),
  };
}

class ForecastCondition {
  final String? code;
  final String? label;
  final String? icon;

  ForecastCondition({this.code, this.label, this.icon});

  factory ForecastCondition.fromJson(Map<String, dynamic> json) =>
      ForecastCondition(
        code: json["code"],
        label: json["label"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {"code": code, "label": label, "icon": icon};
}
