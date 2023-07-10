import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

@JsonSerializable()
class AboutUsResponse {
  @JsonKey(name: 'status')
  final int status;
  @JsonKey(name: 'message')
  final String message;
  @JsonKey(name: 'data')
  final String aboutUsData;

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
        aboutUsData: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": aboutUsData,
      };
}
