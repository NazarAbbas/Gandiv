import 'dart:convert';

class ChangePasswordRequest {
  final String oldPassword;
  final String newPassword;

  ChangePasswordRequest({
    required this.oldPassword,
    required this.newPassword,
  });

  factory ChangePasswordRequest.fromRawJson(String str) =>
      ChangePasswordRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChangePasswordRequest.fromJson(Map<String, dynamic> json) =>
      ChangePasswordRequest(
        oldPassword: json["oldPassword"],
        newPassword: json["newPassword"],
      );

  Map<String, dynamic> toJson() => {
        "oldPassword": oldPassword,
        "newPassword": newPassword,
      };
}
