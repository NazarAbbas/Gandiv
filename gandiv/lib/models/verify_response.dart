import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

@JsonSerializable()
class VerifyResponse {
  @JsonKey(name: 'status')
  final int status;
  @JsonKey(name: 'message')
  final String message;
  @JsonKey(name: 'data')
  final bool data;

  VerifyResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory VerifyResponse.fromRawJson(String str) =>
      VerifyResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VerifyResponse.fromJson(Map<String, dynamic> json) => VerifyResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data,
      };
}
