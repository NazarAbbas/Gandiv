import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

@entity
class ProfileData {
  @primaryKey
  final String? id;
  final String? title;
  final String? firstName;
  final String? lastName;
  final String? mobileNo;
  final String? email;
  final String? gender;
  final String? profileImage;
  final String? role;
  final String? token;

  ProfileData({
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

  factory ProfileData.fromRawJson(String str) =>
      ProfileData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
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
