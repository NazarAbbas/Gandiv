import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

class UpdateProfileRequest {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'userType')
  String? userType;
  @JsonKey(name: 'firstname')
  String? firstName;
  @JsonKey(name: 'lastName')
  String? lastName;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'file')
  String? file;

  UpdateProfileRequest({
    required this.id,
    required this.userType,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.file,
  });

  factory UpdateProfileRequest.fromRawJson(String str) =>
      UpdateProfileRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpdateProfileRequest.fromJson(Map<String, dynamic> json) =>
      UpdateProfileRequest(
        id: json["id"],
        userType: json["userType"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        file: json["file"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userType": userType,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "file": file,
      };
}
