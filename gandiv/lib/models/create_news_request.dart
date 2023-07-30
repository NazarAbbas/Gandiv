import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class CreateNewsRequest {
  final String? heading;
  final String? subHeading;
  final String? newsContent;
  final String? durationInMin;
  final String? locationId;
  final String? categoryId;
  final String? languageId;
  final String? status;
  final List<File>? multiPartFile;

  CreateNewsRequest({
    required this.heading,
    required this.subHeading,
    required this.newsContent,
    required this.durationInMin,
    required this.locationId,
    required this.categoryId,
    required this.languageId,
    required this.status,
    required this.multiPartFile,
  });

  factory CreateNewsRequest.fromRawJson(String str) =>
      CreateNewsRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreateNewsRequest.fromJson(Map<String, dynamic> json) =>
      CreateNewsRequest(
        heading: json["heading"],
        subHeading: json["subHeading"],
        newsContent: json["newsContent"],
        durationInMin: json["durationInMin"],
        locationId: json["locationId"],
        categoryId: json["categoryId"],
        languageId: json["languageId"],
        status: json["status"],
        multiPartFile: json["multiPartFile"],
      );

  Map<String, dynamic> toJson() => {
        "heading": heading,
        "subHeading": subHeading,
        "newsContent": newsContent,
        "durationInMin": durationInMin,
        "locationId": locationId,
        "categoryId": categoryId,
        "languageId": languageId,
        "status": status,
        "multiPartFile": multiPartFile,
      };
}
