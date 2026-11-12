// To parse this JSON data, do
//
//     final cityDetailsModel = cityDetailsModelFromJson(jsonString);

import 'dart:convert';

CityDetailsModel cityDetailsModelFromJson(String str) =>
    CityDetailsModel.fromJson(json.decode(str));

String cityDetailsModelToJson(CityDetailsModel data) =>
    json.encode(data.toJson());

class CityDetailsModel {
  final CityDetails? data;

  CityDetailsModel({this.data});

  factory CityDetailsModel.fromJson(Map<String, dynamic> json) =>
      CityDetailsModel(
        data: json["data"] == null ? null : CityDetails.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {"data": data?.toJson()};
}

class CityDetails {
  final String? id;
  final String? name;
  final String? country;
  final String? region;
  final String? tagline;
  final int? population;
  final Coordinates? coordinates;
  final String? timezone;

  CityDetails({
    this.id,
    this.name,
    this.country,
    this.region,
    this.tagline,
    this.population,
    this.coordinates,
    this.timezone,
  });

  factory CityDetails.fromJson(Map<String, dynamic> json) => CityDetails(
    id: json["id"],
    name: json["name"],
    country: json["country"],
    region: json["region"],
    tagline: json["tagline"],
    population: json["population"],
    coordinates: json["coordinates"] == null
        ? null
        : Coordinates.fromJson(json["coordinates"]),
    timezone: json["timezone"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "country": country,
    "region": region,
    "tagline": tagline,
    "population": population,
    "coordinates": coordinates?.toJson(),
    "timezone": timezone,
  };
}

class Coordinates {
  final double? lat;
  final double? lon;

  Coordinates({this.lat, this.lon});

  factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
    lat: json["lat"]?.toDouble(),
    lon: json["lon"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {"lat": lat, "lon": lon};
}
