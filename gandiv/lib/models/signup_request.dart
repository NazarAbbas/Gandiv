import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

@JsonSerializable()
class SignupRequest {
  @JsonKey(name: 'firstname')
  final String firstname;
  @JsonKey(name: 'lastname')
  final String lastname;
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'password')
  final String password;
  @JsonKey(name: 'userType')
  int userType;

  SignupRequest({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
    required this.userType,
  });

  factory SignupRequest.fromRawJson(String str) =>
      SignupRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SignupRequest.fromJson(Map<String, dynamic> json) => SignupRequest(
        firstname: json["firstname"],
        lastname: json["lastname"],
        email: json["email"],
        password: json["password"],
        userType: json["userType"],
      );

  Map<String, dynamic> toJson() => {
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "password": password,
        "userType": userType,
      };
}
