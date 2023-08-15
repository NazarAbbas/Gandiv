import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

@JsonSerializable()
class ChangePasswordResponse {
  @JsonKey(name: 'status')
  final int status;
  @JsonKey(name: 'message')
  final String message;
  @JsonKey(name: 'data')
  final String aboutUsData;

  ChangePasswordResponse({
    required this.status,
    required this.message,
    required this.aboutUsData,
  });

  factory ChangePasswordResponse.fromRawJson(String str) =>
      ChangePasswordResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) =>
      ChangePasswordResponse(
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
