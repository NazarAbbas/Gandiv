import 'dart:convert';
import 'package:floor/floor.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class CategoriesResponse {
  @JsonKey(name: 'status')
  int status;
  @JsonKey(name: 'message')
  String message;
  @JsonKey(name: 'data')
  List<Categories> data;

  CategoriesResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CategoriesResponse.fromRawJson(String str) =>
      CategoriesResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) =>
      CategoriesResponse(
        status: json["status"],
        message: json["message"],
        data: List<Categories>.from(
            json["data"].map((x) => Categories.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

@entity
class Categories {
  @primaryKey
  String id;
  String name;
  String? hindiName;
  int catOrder;
  bool isActive;

  Categories({
    required this.id,
    required this.name,
    required this.hindiName,
    required this.catOrder,
    required this.isActive,
  });

  factory Categories.fromRawJson(String str) =>
      Categories.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        id: json["id"],
        name: json["name"],
        hindiName: json["hindiName"] ?? "",
        catOrder: json["catOrder"] ?? 0,
        isActive: json["isActive"] ?? true,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "hindiName": hindiName,
        "catOrder": catOrder,
        "isActive": isActive,
      };
}
