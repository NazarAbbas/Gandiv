import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

class ForgotPasswordResponse {
  @JsonKey(name: 'status')
  final int status;
  @JsonKey(name: 'message')
  final String message;
  @JsonKey(name: 'data')
  final bool forgorPasswordData;

  ForgotPasswordResponse({
    required this.status,
    required this.message,
    required this.forgorPasswordData,
  });

  factory ForgotPasswordResponse.fromRawJson(String str) =>
      ForgotPasswordResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) =>
      ForgotPasswordResponse(
        status: json["status"],
        message: json["message"],
        forgorPasswordData: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": forgorPasswordData,
      };
}
