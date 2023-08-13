import 'dart:convert';
import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

class UpdateProfileRequest {
  @JsonKey(name: 'Firstname')
  String? firstName;
  @JsonKey(name: 'LastName')
  String? lastName;
  @JsonKey(name: 'Email')
  String? email;
  @JsonKey(name: 'MobileNo')
  String? mobileNo;
  @JsonKey(name: 'File')
  File? file;

  UpdateProfileRequest({
    this.firstName,
    this.lastName,
    this.email,
    this.file,
    this.mobileNo,
  });

  factory UpdateProfileRequest.fromRawJson(String str) =>
      UpdateProfileRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpdateProfileRequest.fromJson(Map<String, dynamic> json) =>
      UpdateProfileRequest(
        firstName: json["Firstname"],
        lastName: json["LastName"],
        email: json["Email"],
        mobileNo: json["MobileNo"],
        file: json["File"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "MobileNo": mobileNo,
        "file": file,
      };
}
