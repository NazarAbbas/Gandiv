import 'dart:convert';
import 'dart:ffi';

import 'package:freezed_annotation/freezed_annotation.dart';

@JsonSerializable()
class CreateNewsRequest {
  @JsonKey(name: 'heading')
  final String heading;
  @JsonKey(name: 'subHeading')
  final String subHeading;
  @JsonKey(name: 'newsContent')
  final String newsContent;
  @JsonKey(name: 'durationInMin')
  final int durationInMin;
  @JsonKey(name: 'locationId')
  final String locationId;
  @JsonKey(name: 'categoryId')
  final String categoryId;
  @JsonKey(name: 'languageId')
  final int languageId;
  @JsonKey(name: 'status')
  final String status;

  CreateNewsRequest({
    required this.heading,
    required this.subHeading,
    required this.newsContent,
    required this.durationInMin,
    required this.locationId,
    required this.categoryId,
    required this.languageId,
    required this.status,
  });

  factory CreateNewsRequest.fromRawJson(String str) =>
      CreateNewsRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreateNewsRequest.fromJson(Map<String, dynamic> json) =>
      CreateNewsRequest(
        heading: json["heading"],
        subHeading: json["subHeading"],
        newsContent: json["newsContent"],
        durationInMin: json["durationInMin"],
        locationId: json["locationId"],
        categoryId: json["categoryId"],
        languageId: json["languageId"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "heading": heading,
        "subHeading": subHeading,
        "newsContent": newsContent,
        "durationInMin": durationInMin,
        "locationId": locationId,
        "categoryId": categoryId,
        "languageId": languageId,
        "status": status,
      };
}
