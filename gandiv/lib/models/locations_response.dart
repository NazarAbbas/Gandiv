import 'dart:convert';
import 'package:floor/floor.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class LocationsResponse {
  @JsonKey(name: 'status')
  int status;
  @JsonKey(name: 'message')
  String message;
  @JsonKey(name: 'data')
  List<Locations> data;

  LocationsResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory LocationsResponse.fromRawJson(String str) =>
      LocationsResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LocationsResponse.fromJson(Map<String, dynamic> json) =>
      LocationsResponse(
        status: json["status"],
        message: json["message"],
        data: List<Locations>.from(
            json["data"].map((x) => Locations.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

@entity
class Locations {
  @primaryKey
  String? id;
  String? name;

  Locations({
    this.id,
    this.name,
  });

  factory Locations.fromRawJson(String str) =>
      Locations.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Locations.fromJson(Map<String, dynamic> json) => Locations(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
