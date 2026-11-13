// To parse this JSON data, do
//
//     final getFavorites = getFavoritesFromJson(jsonString);

import 'dart:convert';

GetFavorites getFavoritesFromJson(String str) =>
    GetFavorites.fromJson(json.decode(str));

String getFavoritesToJson(GetFavorites data) => json.encode(data.toJson());

class GetFavorites {
  final List<FavoritesList>? data;
  final Meta? meta;

  GetFavorites({this.data, this.meta});

  factory GetFavorites.fromJson(Map<String, dynamic> json) => GetFavorites(
    data: json["data"] == null
        ? []
        : List<FavoritesList>.from(
            json["data"]!.map((x) => FavoritesList.fromJson(x)),
          ),
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
    "meta": meta?.toJson(),
  };
}

class FavoritesList {
  final int? id;
  final String? note;
  final DateTime? createdAt;
  final City? city;

  FavoritesList({this.id, this.note, this.createdAt, this.city});

  factory FavoritesList.fromJson(Map<String, dynamic> json) => FavoritesList(
    id: json["id"],
    note: json["note"],
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    city: json["city"] == null ? null : City.fromJson(json["city"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "note": note,
    "createdAt": createdAt?.toIso8601String(),
    "city": city?.toJson(),
  };
}

class City {
  final String? id;
  final String? name;
  final String? country;
  final Weather? weather;

  City({this.id, this.name, this.country, this.weather});

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json["id"],
    name: json["name"],
    country: json["country"],
    weather: json["weather"] == null ? null : Weather.fromJson(json["weather"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "country": country,
    "weather": weather?.toJson(),
  };
}

class Weather {
  final double? temperatureC;
  final Condition? condition;

  Weather({this.temperatureC, this.condition});

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
    temperatureC: json["temperatureC"]?.toDouble(),
    condition: json["condition"] == null
        ? null
        : Condition.fromJson(json["condition"]),
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

  Condition({this.code, this.label, this.icon});

  factory Condition.fromJson(Map<String, dynamic> json) =>
      Condition(code: json["code"], label: json["label"], icon: json["icon"]);

  Map<String, dynamic> toJson() => {"code": code, "label": label, "icon": icon};
}

class Meta {
  final int? total;

  Meta({this.total});

  factory Meta.fromJson(Map<String, dynamic> json) =>
      Meta(total: json["total"]);

  Map<String, dynamic> toJson() => {"total": total};
}
