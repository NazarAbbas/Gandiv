import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

@JsonSerializable()
class UpdateProfilleResponse {
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'data')
  SignupData? signupData;

  UpdateProfilleResponse({
    this.status,
    this.message,
    this.signupData,
  });

  factory UpdateProfilleResponse.fromRawJson(String str) =>
      UpdateProfilleResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpdateProfilleResponse.fromJson(Map<String, dynamic> json) =>
      UpdateProfilleResponse(
        status: json["status"],
        message: json["message"],
        signupData: SignupData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": signupData?.toJson(),
      };
}

@JsonSerializable()
class SignupData {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'firstName')
  final String? firstName;
  @JsonKey(name: 'lastName')
  final String? lastName;
  @JsonKey(name: 'mobileNo')
  final String? mobileNo;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'gender')
  final String? gender;
  @JsonKey(name: 'profileImage')
  final String? profileImage;
  @JsonKey(name: 'role')
  final String? role;
  @JsonKey(name: 'token')
  final String? token;

  SignupData({
    required this.id,
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.mobileNo,
    required this.email,
    required this.gender,
    required this.profileImage,
    required this.role,
    required this.token,
  });

  factory SignupData.fromRawJson(String str) =>
      SignupData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SignupData.fromJson(Map<String, dynamic> json) => SignupData(
        id: json["id"],
        title: json["title"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        mobileNo: json["mobileNo"],
        email: json["email"],
        gender: json["gender"],
        profileImage: json["profileImage"],
        role: json["role"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "firstName": firstName,
        "lastName": lastName,
        "mobileNo": mobileNo,
        "email": email,
        "gender": gender,
        "profileImage": profileImage,
        "role": role,
        "token": token,
      };
}
