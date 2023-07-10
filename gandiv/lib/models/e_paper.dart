import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

@JsonSerializable()
class EPaperResponse {
  @JsonKey(name: 'status')
  final int status;
  @JsonKey(name: 'message')
  final String message;
  @JsonKey(name: 'data')
  final String ePaperData;

  EPaperResponse({
    required this.status,
    required this.message,
    required this.ePaperData,
  });

  factory EPaperResponse.fromRawJson(String str) =>
      EPaperResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EPaperResponse.fromJson(Map<String, dynamic> json) => EPaperResponse(
        status: json["status"],
        message: json["message"],
        ePaperData: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": ePaperData,
      };
}
