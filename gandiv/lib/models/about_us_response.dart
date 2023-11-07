import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

@JsonSerializable()
class AboutUsResponse {
  @JsonKey(name: 'status')
  final int status;
  @JsonKey(name: 'message')
  final String message;
  @JsonKey(name: 'data')
  final AboutusData aboutUsData;

  AboutUsResponse({
    required this.status,
    required this.message,
    required this.aboutUsData,
  });

  factory AboutUsResponse.fromRawJson(String str) =>
      AboutUsResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AboutUsResponse.fromJson(Map<String, dynamic> json) =>
      AboutUsResponse(
          status: json["status"],
          message: json["message"],
          aboutUsData: AboutusData.fromJson(json["data"]));

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": aboutUsData,
      };
}

@JsonSerializable()
class AboutusData {
  @JsonKey(name: 'content')
  final String? content;
  @JsonKey(name: 'media')
  final String? media;

  AboutusData({
    this.content,
    this.media,
  });

  factory AboutusData.fromRawJson(String str) =>
      AboutusData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AboutusData.fromJson(Map<String, dynamic> json) => AboutusData(
        content: json["content"],
        media: json["media"],
      );

  Map<String, dynamic> toJson() => {
        "content": content,
        "media": media,
      };
}
