// To parse this JSON data, do
//
//     final cityPlacesModel = cityPlacesModelFromJson(jsonString);

import 'dart:convert';

CityPlacesModel cityPlacesModelFromJson(String str) =>
    CityPlacesModel.fromJson(json.decode(str));

String cityPlacesModelToJson(CityPlacesModel data) =>
    json.encode(data.toJson());

class CityPlacesModel {
  final List<Place>? data;

  CityPlacesModel({this.data});

  factory CityPlacesModel.fromJson(Map<String, dynamic> json) =>
      CityPlacesModel(
        data: json["data"] == null
            ? []
            : List<Place>.from(json["data"]!.map((x) => Place.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Place {
  final String? id;
  final String? name;
  final String? type;

  Place({this.id, this.name, this.type});

  factory Place.fromJson(Map<String, dynamic> json) => Place(
    id: json["id"],
    name: json["name"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {"id": id, "name": name, "type": type};
}
