import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

class CreateNewsResponse {
  @JsonKey(name: 'status')
  int status;
  @JsonKey(name: 'message')
  String message;
  @JsonKey(name: 'data')
  String data;

  CreateNewsResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CreateNewsResponse.fromRawJson(String str) =>
      CreateNewsResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreateNewsResponse.fromJson(Map<String, dynamic> json) =>
      CreateNewsResponse(
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
