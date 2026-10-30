// To parse this JSON data, do
//
//     final getCtiesModel = getCtiesModelFromJson(jsonString);

import 'dart:convert';

GetCtiesModel getCtiesModelFromJson(String str) => GetCtiesModel.fromJson(json.decode(str));

String getCtiesModelToJson(GetCtiesModel data) => json.encode(data.toJson());

class GetCtiesModel {
  final List<Datum>? data;
  final Meta? meta;

  GetCtiesModel({
    this.data,
    this.meta,
  });

  factory GetCtiesModel.fromJson(Map<String, dynamic> json) => GetCtiesModel(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "meta": meta?.toJson(),
  };
}

class Datum {
  final String? id;
  final String? name;
  final String? country;
  final String? region;
  final String? tagline;
  final int? population;
  final Weather? weather;

  Datum({
    this.id,
    this.name,
    this.country,
    this.region,
    this.tagline,
    this.population,
    this.weather,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    country: json["country"],
    region: json["region"],
    tagline: json["tagline"],
    population: json["population"],
    weather: json["weather"] == null ? null : Weather.fromJson(json["weather"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "country": country,
    "region": region,
    "tagline": tagline,
    "population": population,
    "weather": weather?.toJson(),
  };
}

class Weather {
  final double? temperatureC;
  final Condition? condition;

  Weather({
    this.temperatureC,
    this.condition,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
    temperatureC: json["temperatureC"]?.toDouble(),
    condition: json["condition"] == null ? null : Condition.fromJson(json["condition"]),
  );

  Map<String, dynamic> toJson() => {
    "temperatureC": temperatureC,
    "condition": condition?.toJson(),
  };
}

class Condition {
  final String? code;
  final String? label;
  final String? icon;

  Condition({
    this.code,
    this.label,
    this.icon,
  });

  factory Condition.fromJson(Map<String, dynamic> json) => Condition(
    code: json["code"],
    label: json["label"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "label": label,
    "icon": icon,
  };
}

class Meta {
  final int? page;
  final int? limit;
  final int? total;
  final int? totalPages;
  final bool? hasNext;
  final bool? hasPrev;

  Meta({
    this.page,
    this.limit,
    this.total,
    this.totalPages,
    this.hasNext,
    this.hasPrev,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    page: json["page"],
    limit: json["limit"],
    total: json["total"],
    totalPages: json["totalPages"],
    hasNext: json["hasNext"],
    hasPrev: json["hasPrev"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "limit": limit,
    "total": total,
    "totalPages": totalPages,
    "hasNext": hasNext,
    "hasPrev": hasPrev,
  };
}
