import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

@JsonSerializable()
class UpdateProfilleResponse {
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'data')
  String? updateProfileData;

  UpdateProfilleResponse({
    this.status,
    this.message,
    this.updateProfileData,
  });

  factory UpdateProfilleResponse.fromRawJson(String str) =>
      UpdateProfilleResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpdateProfilleResponse.fromJson(Map<String, dynamic> json) =>
      UpdateProfilleResponse(
        status: json["status"],
        message: json["message"],
        updateProfileData: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": updateProfileData,
      };
}
